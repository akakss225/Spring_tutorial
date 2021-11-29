<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../include/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <form role="form" action="/board/register" method="post">
                            	<div class="form-group">
                            		<label>Title</label> <input class="form-control" name="title">
                            	</div>
                            	<div class="form-group">
                            		<label>Content</label>
                            		<textarea rows="3" name="content" class="form-control"></textarea>
                            	</div>
                            	<div class="form-group">
                            		<label>Writer</label> <input class="form-control" name="writer">
                            	</div>
                            	<button type="submit" class="btn btn-default">post</button>
                            	<button type="reset" class="btn btn-default">reset</button>
                            </form>
                            <!-- /.form -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <!-- 첨부파일 업로드 부분 -->
            <div class="row">
            	<div class="col-lg-12">
            		<div class="panel panel-default">
            			<div class="panel-heading">File Attach</div>
            			<div class="panel-body">
            				<div class="form-group uploadDiv">
            					<input type="file" name="uploadFile" multiple>
            				</div>
            				<div class="uploadResult">
            					<ul>
            					
            					</ul>
            				</div>
            			</div>
            			<!-- end panel-body -->
            		</div>
            		<!-- end panel -->
            	</div>
            	<!-- end col-lg-12 -->
            </div>
            <!-- end row -->

<<script>
	$(document).ready(function(e){
		var formObj = $("form[role='form']");
		
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			
			console.log("submit clicked");
		});
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; // 5MB
		
		// 업로드시 확인할 사항들.
		function checkExtension(fileName, fileSize){
			
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			
			return true;
		}
		
		// 업로드 된 결과를 화면에 처리하는 함수
		function showUploadResult(uploadResultArr){
			if(!uploadResultArr || uploadResultArr.length == 0){return;}
			
			var uploadUL = $(".uploadResult ul");
			
			var str = "";
			
			$(uploadResultArr).each(function(i, obj){
				if(obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" +obj.fileName);
					str += "<li><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' class='btn btn-warning btn-circle' data-file='"+fileCallPath+"' data-type='image'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div></li>";
				}
				else{
					var fileCallPath = 	encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" +obj.fileName);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
					str += "<li><div>";
					str += "<span>" + obj.fileName + "</span>";
					str += "<button type='button' class='btn btn-warning btn-circle' data-file='"+fileCallPath+"' data-type='file'><i class='fa fa-times'></i></button><br>";
					str += "<img src='/resources/img/attach.png'>"
					str += "</div></li>";
				}
			});
			uploadUL.append(str);
		}
		
		// 첨부파일 제거 이벤트
		$(".uploadResult").on("click", "button", function(e){
			console.log("delete file");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			
			var targetLi = $(this).closest("li");
			
			$.ajax({
				url : '/deleteFile',
				data : {fileName : targetFile. type : type},
				dataType : 'text',
				type : 'POST',
				success : function(result){
					alert(result);
					targetLi.remove();
				}
			});
			
		});
		
		$("input[type='file']").change(function(e){
			
			var formData = new FormData();
			
			var inputFile = $("input[name='uploadFile']");
			
			// jQuery의 경우 데이터를 받아올 때 배열로 받아옴.
			var files = inputFile[0].files;
			
			for(var i = 0; i < files.length; i++){
				if(!checkExtension(files[i].name, files[i].size)){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			$.ajax({
				url : '/uploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'POST',
				dataType : 'json',
				success : function(result){
					console.log(result);
					showUploadResult(result);
				}
			});
		});
		
	});
</script>
            
<%@ include file="../include/footer.jsp" %>