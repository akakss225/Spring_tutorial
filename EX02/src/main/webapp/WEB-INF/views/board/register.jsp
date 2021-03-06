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
            
            <!-- ?????????????????? ---------------------------------------------------------------------------->
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
            <!-- ?????????????????? -->
            <script>
            	$(document).ready(function(e){
            		var formObj=$("form[role='form']");
            		$("button[type='submit']").on("click",function(e){
            			//????????????
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
            		
            		//????????????????????? ?????????
        			var regex=new RegExp("(.*?)\.(exe|sh|zip|alz|js|jar)$");
        			var maxSize=5242880; //5Mb
        			function checkExtension(fileName,fileSize){
        				if(fileSize>maxSize){
        					alert("?????? ????????? ??????");
        					return false;
        				}
        				if(regex.test(fileName)){
        					alert("??????????????? ????????? ???????????? ??? ????????????.");
        					return false;
        				}
        				return true;
        			}
        			//????????? ??????
        			var uploadResult=$(".uploadResult ul");
        			function showUploadedFile(uploadResultArr){
        				var str="";
        				$(uploadResultArr).each(function(i,obj){
        					//???????????? ????????? attach.png ??????
        					if(obj.image){
        						//????????? full path
        						var fileCallPath=encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);        											
        						str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-fileName='"+obj.fileName+"' data-type='"+obj.image+"'>";
        						str_="	<div>";
        						str+="		<span> "+obj.fileName+"</span>";
        						str+="		<button type='button' data-file='"+fileCallPath+"' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
        						str+="		<img src='/display?fileName="+fileCallPath+"'>";
        						str+="	</div>"
        						str+="</li>";
        					}else{
        						var fileCallPath=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
        						//??????????????? path        						
        						var fileLink=fileCallPath.replace(new RegExp(/\\/g),"/");  // '\\'??? '/'??? ??????	
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
            		//?????????????????????
            		var csrfHeaderName="${_csrf.headerName}";
            		var csrfTokenValue="${_csrf.token}";
            		
            		
					$("input[type='file']").change(function(e){
						console.log("???????????????");
						
						//FormData?????? ??????. form????????? ???????????? ??????
						var formData=new FormData();
						var inputFile=$("input[name='uploadFile']");
						var files=inputFile[0].files;//????????? ???????????? ??????
						for(var i=0;i<files.length;i++){
							//???????????????,size??????
							if(!checkExtension(files[i].name,files[i].size)){
								return; //??????
							}
							formData.append("uploadFile",files[i]);
						}
						$.ajax({
							url: "/uploadAjaxAction",
							processData: false, //QueryString(uploadAjaxAction?name=hkd)??? ???????????? ?????? 
							contentType: false, //multipart/form-data???????????? ??????
							beforeSend: function(xhr){
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},							
							data: formData,  //formData??????
							type: "POST",
							dataType: "json",
							success: function(result){
								console.log(result);
								
								showUploadedFile(result);//???????????????
								
								// inpu type='file' ?????????
								//$(".uploadDiv").html(cloneObj.html());
							}
						});
					}); 
					//??????????????????.??????
					$(".uploadResult").on("click","button", function(e){	   
					  var targetFile = $(this).data("file");
					  var type = $(this).data("type");	
					  //??????????????? ?????? ????????? ?????? li????????? ?????????.
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
					         targetLi.remove();//li?????? ??????
					       }
					  }); 
					  
					});
            		
					//?????? ???????????? ???????????? ???????????? ??????
					$(".uploadResult").on("dragenter dragover",function(event){
						//?????????????????????.????????? ????????? ??? ??????
						event.preventDefault();
					});
					//?????? ????????? ???????????? ???????????? ??????. ???????????????
					$(".uploadResult").on("drop",function(event){
						//?????????????????????.????????? ????????? ??? ??????
						event.preventDefault();
						
						//FormData?????? ??????. form????????? ???????????? ??????
						var formData=new FormData();
						
						//drop?????? ??? ????????? ????????? ??????
						// input change??? ????????? ?????? ???????????? ???????????? ??????????????? ????????? ????????? ??????????????????.
						var files=event.originalEvent.dataTransfer.files;

						for(var i=0;i<files.length;i++){
							var file=files[i];
							console.log(file);
							//???????????????,size??????
							if(!checkExtension(files[i].name,files[i].size)){
								return; //??????
							}
							formData.append("uploadFile",files[i]);
						}

						$.ajax({
							url: "/uploadAjaxAction",
							processData: false, //QueryString(uploadAjaxAction?name=hkd)??? ???????????? ?????? 
							contentType: false, //multipart/form-data???????????? ??????
							beforeSend: function(xhr){
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},							
							data: formData,  //formData??????
							type: "POST",
							dataType: "json",
							success: function(result){
								console.log(result);
								
								showUploadedFile(result);//???????????????								
							}
						});
						
					});
            		
            	});
            </script>
            
<%@ include file="../include/footer.jsp" %>