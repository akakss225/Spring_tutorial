<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../include/header.jsp" %>
 <style>
.uploadResult{ 
	width:100%;
	height:100px; 
	background-color:gray;
}
.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items: center;
}
.uploadResult ul li{
	list-style:none;
	padding:10px;
}
.uploadResult ul li img{
	width:50px;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
}

.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicture img{
	width:600px;
}

.btn-circle{
	width:25px !important;
	height:25px !important;
	line-height:0px !important;
}
.fa-times{
	font-size:10px !important;
}
</style>
    
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
                            Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<form role="form" action="/board/register" method="post">	
                        	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        	                        	
	                            <div class="form-group">
	                            	<label>Title</label>
	                            	<input class="form-control" name="title">
	                            </div>
	                            <div class="form-group">
	                            	<label>Content</label>
	                            	<textarea class="form-control" name="content"></textarea>
	                            </div>
	                            <div class="form-group">
	                            	<label>Writer</label>
	                            	<input class="form-control" name="writer" value='<sec:authentication property="principal.username"/>' readonly>
	                            </div>
	                            <button type="submit" class="btn btn-default">Submit</button>
	                            <button type="reset" class="btn btn-default">Reset</button>
                        	</form>                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->            
            
            <!-- 첨부파일등록 ---------------------------------------------------------------------------->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            File Attach
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">                        	                      	
                          	<div class="form-group uploadDiv">	                            	
                            	<input type="file" name="uploadFile" multiple>
                            </div>
                            <div class="uploadResult">
                            	<ul>
                            	</ul>
                            </div>            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->  
            <!-- 첨부파일등록 -->
            <script>
            	$(document).ready(function(e){
            		var formObj=$("form[role='form']");
            		$("button[type='submit']").on("click",function(e){
            			//전송방지
            			e.preventDefault();
            			
            			var str="";
            			$(".uploadResult ul li").each(function(i,obj){
            				var jobj=$(obj);
            				str+="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
            				str+="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
            				str+="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
            				str+="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
            			});
            			formObj.append(str).submit();
            		});
            		
            		//파일확장자체크 정규식
        			var regex=new RegExp("(.*?)\.(exe|sh|zip|alz|js|jar)$");
        			var maxSize=5242880; //5Mb
        			function checkExtension(fileName,fileSize){
        				if(fileSize>maxSize){
        					alert("파일 사이즈 초과");
        					return false;
        				}
        				if(regex.test(fileName)){
        					alert("해당종류의 파일은 업로드할 수 없습니다.");
        					return false;
        				}
        				return true;
        			}
        			//파일명 출력
        			var uploadResult=$(".uploadResult ul");
        			function showUploadedFile(uploadResultArr){
        				var str="";
        				$(uploadResultArr).each(function(i,obj){
        					//이미지가 아니면 attach.png 출력
        					if(obj.image){
        						//썸네일 full path
        						var fileCallPath=encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);        											
        						str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='"+obj.image+"'>";
        						str_="	<div>";
        						str+="		<span> "+obj.fileName+"</span>";
        						str+="		<button type='button' data-file='"+fileCallPath+"' data-type='image' class='btn btn-warning btn-cricle'><i class='fa fa-times'></i></button><br>"
        						str+="		<img src='/display?fileName="+fileCallPath+"'>";
        						str+="	</div>"
        						str+="</li>";
        					}else{
        						var fileCallPath=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
        						//원본이미지 path        						
        						var fileLink=fileCallPath.replace(new RegExp(/\\/g),"/");  // '\\'를 '/'로 변경	
       						 	str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='"+obj.image+"'>";
       						 	str+="	<div>";
       						 	str+="	<span> "+obj.fileName+"</span>";
       						 	str+="	<button type='button' data-file='"+fileCallPath+"' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
       						 	str+="	<img src='/resources/img/attach.png'></a>";
       				            str+="	</div>";
       				            str+="</li>";
        					}			
        				});
        				uploadResult.append(str);
        			}	
            		//첨부파일업로드
            		var csrfHeaderName="${_csrf.headerName}";
            		var csrfTokenValue="${_csrf.token}";
            		
            		
					$("input[type='file']").change(function(e){
						console.log("파일업로드");
						
						//FormData객체 생성. form태그에 대응하는 객체
						var formData=new FormData();
						var inputFile=$("input[name='uploadFile']");
						var files=inputFile[0].files;//선택한 파일들을 저장
						for(var i=0;i<files.length;i++){
							//파일확장자,size체크
							if(!checkExtension(files[i].name,files[i].size)){
								return; //중지
							}
							formData.append("uploadFile",files[i]);
						}
						$.ajax({
							url: "/uploadAjaxAction",
							processData: false, //QueryString(uploadAjaxAction?name=hkd)을 생성하지 않고 
							contentType: false, //multipart/form-data형식으로 보냄
							beforeSend: function(xhr){
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},							
							data: formData,  //formData전송
							type: "POST",
							dataType: "json",
							success: function(result){
								console.log(result);
								
								showUploadedFile(result);//파일명출력
								
								// inpu type='file' 초기화
								//$(".uploadDiv").html(cloneObj.html());
							}
						});
					}); 
					//파일삭제처리.위임
					$(".uploadResult").on("click","button", function(e){	   
					  var targetFile = $(this).data("file");
					  var type = $(this).data("type");	
					  //부모태그중 가장 가까이 있는 li태그를 찾는다.
					  var targetLi=$(this).closest("li");
					  
					  $.ajax({
					    url: '/deleteFile',
					    data: {fileName: targetFile, type:type},
					    dataType:'text',
					    beforeSend: function(xhr){
							xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
						},	
					    type: 'POST',
					    success: function(result){
					         alert(result);	
					         targetLi.remove();//li태그 삭제
					       }
					  }); 
					  
					});
            		
					//파일 드래그시 새창으로 열리는것 방지
					$(".uploadResult").on("dragenter dragover",function(event){
						//기본이벤트취소.새창이 열리는 것 방지
						event.preventDefault();
					});
					//파일 드롭시 새창으로 열리는것 방지. 파일업로드
					$(".uploadResult").on("drop",function(event){
						//기본이벤트취소.새창이 열리는 것 방지
						event.preventDefault();
						
						//FormData객체 생성. form태그에 대응하는 객체
						var formData=new FormData();
						
						//drop했을 때 파일의 목록을 구함
						// input change로 하는게 아닌 드래그앤 드랍으로 하는것이기 때문에 필수로 들어가야한다.
						var files=event.originalEvent.dataTransfer.files;

						for(var i=0;i<files.length;i++){
							var file=files[i];
							console.log(file);
							//파일확장자,size체크
							if(!checkExtension(files[i].name,files[i].size)){
								return; //중지
							}
							formData.append("uploadFile",files[i]);
						}

						$.ajax({
							url: "/uploadAjaxAction",
							processData: false, //QueryString(uploadAjaxAction?name=hkd)을 생성하지 않고 
							contentType: false, //multipart/form-data형식으로 보냄
							beforeSend: function(xhr){
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},							
							data: formData,  //formData전송
							type: "POST",
							dataType: "json",
							success: function(result){
								console.log(result);
								
								showUploadedFile(result);//파일명출력								
							}
						});
						
					});
            		
            	});
            </script>
            
<%@ include file="../include/footer.jsp" %>