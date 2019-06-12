<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<c:set var="extLibs" value="webuploader" />
<sys:header title="文件上传管理" extLibs="${extLibs}" />
<div class="portlet box ${boxStyleColor} autoHeight">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-coffee"></i>上传附件
		</div>
	</div>
	<div class="portlet-body form">
		<form id="fileParmForm">
			<input id="bizCategory" name="bizCategory" type="hidden" value="测试" /> <input id="bizKey" name="bizKey" type="hidden" value="biz_test_123456" /> <input id="uploadType" name="uploadType" type="hidden" value="image" /> <input id="multiFile" name="multiFile" type="hidden" value="true" />
			<%-- <input id="imageMaxWidth" name="imageMaxWidth" type="hidden" value="${imageMaxWidth}" />
			<input	id="imageMaxHeight" name="imageMaxHeight" type="hidden" value="${imageMaxHeight}" /> 
			<input id="allowServerSelect" name="allowServerSelect" type="hidden" value="${allowServerSelect}" />
			<input id="maxUploadNum" name="maxUploadNum" type="hidden" value="${maxUploadNum}" /> 
			<input id="lazyUpload" name="lazyUpload" type="hidden" value="${lazyUpload}" /> --%>
		</form>
		<div class="form-body">
			<div class="container">
				<div class="area " id="upload_area">
					<div id="uploader" class="web_uploader_wrap">
						<div class="statusBar" style="display: none;">
							<div class="progress">
								<span class="text">0%</span> <span class="percentage"></span>
							</div>
							<div class="info"></div>
							<div class="btns">
								<div id="filePicker2"></div>
								<div class="uploadBtn">开始上传</div>
							</div>
						</div>
						<div class="queueList">
							<div id="dndArea" class="placeholder">
								<div id="filePicker"></div>
								<p>或将文件拖到这里，单次最多可选300个</p>
							</div>
							<div class="table-scrollable   ">
								<table class="table table-striped filetable table-hover">
									<tbody id="fileLists">

									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<sys:footer extLibs="${extLibs}" />
<script type="text/javascript">
	
	function dataAddFormJson(formObj, o) {
		var a = formObj.serializeArray();
		$.each(a, function() {
			if (o[this.name] !== undefined) {
				if (!o[this.name].push) {
					o[this.name] = [ o[this.name] ];
				}
				o[this.name].push(this.value || '');
			} else {
				o[this.name] = this.value || '';
			}
		});
		return o;
	};

	(function($) {
	    // 当domReady的时候开始初始化
	    $(function() {
	        var $wrap = $('#uploader'),
	        md5 = "",
	        // 图片容器
	        $queue = $wrap.find('#fileLists'),
	        $filetable = $wrap.find('.filetable'),
	        // 状态栏，包括进度和控制按钮
	        $statusBar = $wrap.find('.statusBar'),
	        // 文件总体选择信息。
	        $info = $statusBar.find('.info'),
	        // 上传按钮
	        $upload = $wrap.find('.uploadBtn'),
	        // 没选择文件之前的内容。
	        $placeHolder = $wrap.find('.placeholder'),
	        $progress = $statusBar.find('.progress').hide(),
	        // 添加的文件数量
	        fileCount = 0,
	        // 添加的文件总大小
	        fileSize = 0,
	        // 优化retina, 在retina下这个值是2
	        ratio = window.devicePixelRatio || 1,
	        // 缩略图大小
	        thumbnailWidth = 110 * ratio,
	        thumbnailHeight = 110 * ratio,
	        // 可能有pedding, ready, uploading, confirm, done.
	        state = 'pedding',
	        // 所有文件的进度信息，key为file id
	        percentages = {},
	        // 判断浏览器是否支持图片的base64
	        isSupportBase64 = (function() {
	            var data = new Image();
	            var support = true;
	            data.onload = data.onerror = function() {
	                if (this.width != 1 || this.height != 1) {
	                    support = false;
	                }
	            }
	            data.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
	            return support;
	        })(),
	        // 检测是否已经安装flash，检测flash的版本
	        flashVersion = (function() {
	            var version;
	            try {
	                version = navigator.plugins['Shockwave Flash'];
	                version = version.description;
	            } catch(ex) {
	                try {
	                    version = new ActiveXObject('ShockwaveFlash.ShockwaveFlash').GetVariable('$version');
	                } catch(ex2) {
	                    version = '0.0';
	                }
	            }
	            version = version.match(/\d+/g);
	            return parseFloat(version[0] + '.' + version[1], 10);
	        })(),
	        supportTransition = (function() {
	            var s = document.createElement('p').style,
	            r = 'transition' in s
	            || 'WebkitTransition' in s
	            || 'MozTransition' in s
	            || 'msTransition' in s || 'OTransition' in s;
	            s = null;
	            return r;
	        })(),
	        // WebUploader实例
	        uploader;
	        var formData = {};
	        dataAddFormJson($('#fileParmForm'), formData);
	        if (!WebUploader.Uploader.support('flash')&& WebUploader.browser.ie) {
	            // flash 安装了但是版本过低。
	            if (flashVersion) {
	                (function(container) {
	                    window['expressinstallcallback'] = function(state) {
	                        switch (state) {
	                            case 'Download.Cancelled':
	                            alert('您取消了更新！')
	                            break;
	                            case 'Download.Failed':
	                            alert('安装失败')
	                            break;
	                            default:
	                            alert('安装已成功，请刷新！');
	                            break;
	                        }
	                        delete window['expressinstallcallback'];
	                    };
	                    var swf = '${ctxStatic}/webuploader/attachment/expressInstall.swf';
	                    // insert flash object
	                    var html = '<object type="application/'
	                    + 'x-shockwave-flash" data="' + swf + '" ';
	                    if (WebUploader.browser.ie) {
	                        html += 'classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" ';
	                    }
	                    html += 'width="100%" height="100%" style="outline:0">'
	                    + '<param name="movie" value="' + swf + '" />'
	                    + '<param name="wmode" value="transparent" />'
	                    + '<param name="allowscriptaccess" value="always" />'
	                    + '</object>';
	                    container.html(html);
	                })($wrap);
	                // 压根就没有安转。
	            } else {
	                $wrap.html('<a href="http://www.adobe.com/go/getflashplayer" target="_blank" border="0"><img alt="get flash player" src="http://www.adobe.com/macromedia/style_guide/images/160x41_Get_Flash_Player.jpg" /></a>');
	            }
	            return;
	        } else if (!WebUploader.Uploader.support()) {
	            alert('Web Uploader 不支持您的浏览器！');
	            return;
	        }
	        // 实例化
	        uploader = WebUploader.create({
	            pick: {
	                id: '#filePicker',
	                label: '点击选择文件'
	            },
	            dnd: '#dndArea',
	            paste: '#uploader',
	            swf: '${ctxStatic}/webuploader/0.1.5/Uploader.swf',
	            chunked: false,
	            chunkSize: 512 * 1024,
	            server: '${ctx}/file/uploadFile',
	            // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
	            disableGlobalDnd: true,
	            fileNumLimit: 30,
	            fileSizeLimit: 200 * 1024 * 1024,// 200 M
	            fileSingleSizeLimit: 5 * 1024 * 1024// 5M
	        });
	        // 拖拽时不接受 js, txt 文件。
	        uploader.on('dndAccept', 
	        function(items) {
	            var denied = false,
	            len = items.length,
	            i = 0,
	            // 修改js类型
	            unAllowed = 'text/plain;application/javascript ';
	            for (; i < len; i++) {
	                // 如果在列表里面
	                if (~unAllowed.indexOf(items[i].type)) {
	                    denied = true;
	                    break;
	                }
	            }
	            return ! denied;
	        });
	        // 添加“添加文件”的按钮，
	        uploader.addButton({
	            id: '#filePicker2',
	            label: '继续添加'
	        });
	        
	        uploader.on('ready',  function() {
	            window.uploader = uploader;
	        });
	        // 当有文件添加进来时执行，负责view的创建
	        function addFile(file) {
	            uploader.md5File(file).then(
	            function(val) {
	                var $li = $('<tr id="' + file.id + '" class="template-upload"  ><input id="' + file.id + '_md5" name="' + file.id + '_md5" type="hidden" value="' + val + '"/>'
	                + '<td class="name">'+ file.name+ '</td>'
	                + '<td  class="size">'+ WebUploader.formatSize(file.size)+ '</td>'
	                + '<td class="prog_bar"><p class="progress" style="height:18px;margin-bottom:0px;"><span class="text">0%</span><span class="percentage"></span></p></td>'
	                + '</tr>'),
	                $prgress = $li.find('p.progress span'),
	                $info = $('<td class="msg"></td>'),
	                showError = function(code) {
	                    var text = "";
	                    switch (code) {
	                        case 'exceed_size':
	                        text = "<span class='label label-sm label-danger'>文件大小超出</span>";
	                        break;
	                        case 'interrupt':
	                        text = "<span class='label label-sm label-danger'>文件传输中断</span>";
	                        break;
	                        case 'http':
	                        text = "<span class='label label-sm label-danger'>http请求错误</span>";
	                        break;
	                        case 'not_allow_type':
	                        text = "<span class='label label-sm label-danger'>文件格式不允许</span>";
	                        break;
	                        case 'server':
	                        text = "<span class='label label-sm label-danger'>文件不存在</span>";
	                        break;
	                        default:
	                        text = "<span class='label label-sm label-danger'>上传失败，请重试</span>";
	                        break;
	                    }
	                    $info.html(text);
	                };
	                if (file.getStatus() === 'invalid') {
	                    showError(file.statusText);
	                    $info.appendTo($li);
	                } else {
	                    percentages[file.id] = [file.size, 0];
	                    file.rotation = 0;
	                    $info.text("等待上传").appendTo($li);
	                }
	                $btns = $('<td class="btncancel" ><a class="btn default btn-xs yellow" ><i class="fa fa-ban"></i> 取消 </a></td>').appendTo($li);
	                file.on('statuschange', 
	                function(cur, prev) {
	                    if (prev === 'progress') {
	                        //$prgress.hide().width(0);
	                        } else if (prev === 'queued') {
	                        //$btns.remove();
	                        }
	                    // 成功
	                    if (cur === 'error'|| cur === 'invalid') {
	                        showError(file.statusText);
	                        percentages[file.id][1] = 1;
	                        $prgress.eq(0).text('0%');
	                        $prgress.eq(1).css('width', '0%');
	                    } else if (cur === 'interrupt') {
	                        showError('interrupt');
	                        $prgress.eq(0).text('0%');
	                        $prgress.eq(1).css('width', '0%');
	                    } else if (cur === 'queued') {
	                        percentages[file.id][1] = 0;
	                        $prgress.eq(0).text('0%');
	                        $prgress.eq(1).css('width', '0%');
	                    } else if (cur === 'progress') {
	                        //$info.remove();
	                        $info.text("正在上传");
	                        $prgress.css('display',  'block');
	                    } else if (cur === 'complete') {
	                    	// $prgress.css('display',  'none');
	                        }
	                    $li.removeClass('state-'+ prev).addClass('state-'+ cur);
	                });
	                $btns.on('click', ' a', function() {
	                    var index = $(this).index();
	                    switch (index) {
	                        case 0:
	                        uploader.removeFile(file);
	                        return;
	                        case 1:
	                        formData["fileUserId"] = $(this).attr("fileUserId");
	                        formData["fileId"] = $(this).attr("fileId");
	                        confirmx("确定删除该附件吗?", "${ctx}/file/delFile", formData,  function(data) {
	                            if (data) {
	                                if (data.result == "true") {
	                                    uploader.removeFile(file);
	                                }
	                                showTip(data.message);
	                            }
	                        });
	                        return;
	                    };
	                })
	                $li.appendTo($queue);
	            })
	        }
	        // 负责view的销毁
	        function removeFile(file) {
	            var $li = $('#' + file.id);
	            delete percentages[file.id];
	            updateTotalProgress();
	            $li.remove();
	        }

	        function updateTotalProgress() {
	            var loaded = 0,
	            total = 0,
	            spans = $progress.children(),
	            percent;
	            $.each(percentages,  function(k, v) {
	                total += v[0];
	                loaded += v[0] * v[1];
	            });
	            percent = total ? loaded / total: 0;
	            spans.eq(0).text(Math.round(percent * 100) + '%');
	            spans.eq(1).css('width', Math.round(percent * 100) + '%');
	            updateStatus();
	        }
	        function updateStatus() {
	            var text = '',
	            stats;
	            if (state === 'ready') {
	                text = '选中' + fileCount + '个文件，共'+ WebUploader.formatSize(fileSize) + '。';
	            } else if (state === 'confirm') {
	                stats = uploader.getStats();
	                if (stats.uploadFailNum) {
	                    text = '已成功上传' + stats.successNum  + '个文件，'   + 
	                    // stats.uploadFailNum + '个文件上传失败，<a class="retry" href="#">重新上传</a>失败';
	                    stats.uploadFailNum + '个文件上传失败，<a class="retry" href="#">重新上传</a>失败或<a class="ignore" href="#">忽略</a>';
	                }
	            } else {
	                stats = uploader.getStats();
	                text = '共' + fileCount + '个（'+ WebUploader.formatSize(fileSize) + '），已上传'
	                + stats.successNum + '个';
	                if (stats.uploadFailNum) {
	                    text += '，失败' + stats.uploadFailNum + '个';
	                }

	            }
	            $info.html(text);
	        }

	        function setState(val) {
	            var file,stats;
	            if (val === state) {
	                return;
	            }
	            $upload.removeClass('state-' + state);
	            $upload.addClass('state-' + val);
	            state = val;
	            switch (state) {
	                case 'pedding':
	                $placeHolder.removeClass('element-invisible');
	                $queue.hide();
	                $statusBar.addClass('element-invisible');
	                uploader.refresh();
	                break;
	                case 'ready':
	                $placeHolder.addClass('element-invisible');
	                $('#filePicker2').removeClass('element-invisible');
	                $queue.show();
	                $statusBar.removeClass('element-invisible');
	                uploader.refresh();
	                break;
	                case 'uploading':
	                $('#filePicker2').addClass('element-invisible');
	                $progress.show();
	                $upload.text('暂停上传');
	                break;
	                case 'paused':
	                $progress.show();
	                $upload.text('继续上传');
	                break;
	                case 'confirm':
	                $progress.hide();
	                $('#filePicker2').removeClass('element-invisible');
	                $upload.text('开始上传');
	                stats = uploader.getStats();
	                if (stats.successNum && !stats.uploadFailNum) {
	                    setState('finish');
	                    return;
	                }
	                break;
	                case 'finish':
	                stats = uploader.getStats();
	                if (stats.successNum) {
	                    //alert('上传成功');
	                    } else {
	                    // 没有成功的图片，重设
	                    state = 'done';
	                    location.reload();
	                }
	                break;
	            }
	            updateStatus();
	        }
	        
	        uploader.onUploadProgress = function(file, percentage) {
	            var $li = $('#' + file.id).find(".prog_bar"),
	            $percent = $li
	            .find('.progress span');
	            $percent.eq(0).text(Math.round(percentage * 100) + '%');
	            $percent.eq(1).css('width', Math.round(percentage * 100) + '%');
	            percentages[file.id][1] = percentage;
	            updateTotalProgress();
	        };

	        uploader.onFileQueued = function(file) {
	            fileCount++;
	            fileSize += file.size;
	            if (fileCount === 1) {
	                $placeHolder.addClass('element-invisible');
	                $statusBar.show();

	            }
	            addFile(file);
	            setState('ready');
	            updateTotalProgress();
	        };

	        uploader.onFileDequeued = function(file) {
	            fileCount--;
	            fileSize -= file.size;
	            if (!fileCount) {
	                setState('pedding');
	            }
	            removeFile(file);
	            updateTotalProgress();
	        };

	        uploader.on('all',function(type) {
	            var stats;
	            switch (type) {
	                case 'uploadFinished':
	                setState('confirm');
	                break;

	                case 'startUpload':
	                setState('uploading');
	                break;

	                case 'stopUpload':
	                setState('paused');
	                break;

	            }

	        });

	        uploader.onError = function(code) {
	            var text = "";
	            switch (code) {
	                case 'Q_TYPE_DENIED':
	                text = "文件类型不对";
	                break;
	                case 'F_EXCEED_SIZE':
	                text = "文件大小超出";
	                break;
	                case 'F_DUPLICATE':
	                text = "文件重复";
	                break;
	                case 'Q_EXCEED_NUM_LIMIT':
	                text = "文件数量限制";
	                break;
	                case 'Q_EXCEED_SIZE_LIMIT':
	                text = "文件总大小超出";
	                break;
	                default:
	                text = "上传错误，请重试";
	                break;

	            }
	            showTip(text);

	        };
	        uploader.on('uploadBeforeSend',  function(file, data, header) {
	            header['X_Requested_With'] = 'XMLHttpRequest';
	            data["fileMd5"] = $('#' + data.id + '_md5').val();
	            dataAddFormJson($('#fileParmForm'), data);
	        });

	        uploader.on('uploadAccept', function(file, ret, reject) {
	            var responseText = (ret._raw || ret);
	            var json = JSON.parse(responseText);
	            if (json.result == "false") {
	                reject(json.code);
	                //  return false;
	            }
	        });
	        
	        uploader.on( 'uploadSuccess',  function(file, ret) {
	            var $file = $('#' + file.id).find('.msg');
	            var $btncancel = $('#' + file.id).find(
	            '.btncancel');
	            var $prgress = $('#' + file.id).find(
	            '.progress span');
	            try {
	                var responseText = (ret._raw || ret),
	                json = JSON
	                .parse(responseText);
	                if (json.result == "true") {
	                    $file.html("<span class='label label-sm label-success'>"+ json.message+ "</span>");
	                    $btncancel.find('a').hide();
	                    $('<a class="btn default btn-xs red"  fileId="' + json.fileId + '"  fileUserId="' + json.fileUserId + '"><i class="fa fa-trash-o"></i> 删除 </a>')
	                    .appendTo($btncancel);
	                    $('<a class="btn default btn-xs blue" target="_blank" href="${ctx}/file/download/' + json.fileUserId + '.html" ><i class="fa fa-download"></i> 下载 </a>')
	                    .appendTo($btncancel);

	                } else {
	                    $file.html("<span class='label  label-sm label-danger'>"+ json.message+ "</span>");
	                    $prgress.eq(0).text('0%');
	                    $prgress.eq(1).css('width', '0%');
	                }
	            } catch(e) {
	                $file.html("<span class='label label-sm label-danger'>服务器返回出错</span>");
	                $prgress.eq(0).text('0%');
	                $prgress.eq(1).css('width', '0%');
	            }

	        });

	        $upload.on('click',  function() {
	            if ($(this).hasClass('disabled')) {
	                return false;
	            }
	            if (state === 'ready') {
	                uploader.upload();

	            } else if (state === 'paused') {
	                uploader.upload();

	            } else if (state === 'uploading') {
	                uploader.stop();

	            }

	        });

	        $info.on('click', '.retry', function() {
	            uploader.retry();

	        });

	        $info.on('click', '.ignore', function() {
	            var file,i, files = uploader.getFiles('error');
	            for (i = 0; file = files[i++];) {
	                uploader.removeFile(file);
	            }
	            setState('finish');
	            updateTotalProgress();

	        });

	        $upload.addClass('state-' + state);
	        updateTotalProgress();

	    });

	})(jQuery);
</script>