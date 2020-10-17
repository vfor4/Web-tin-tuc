<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.servletContext.contextPath}/">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">
<script type="text/javascript"
	src="resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<style type="text/css">
body {
	margin: 0px;
	border: 0px;
	padding: 0px;
	content: 0px;
}
</style>
<title>Spring MVC</title>
</head>
<body>
	<!-- Navigation -->
	<div class="container" style="margin: auto; margin-top: 50px;">
		<div class="row">
			<div class="col-md-8 col-sm-8">
				<form action="upload/image.htm" enctype="multipart/form-data"
					method="post">
					<div class="input-group">
						<div class="custom-file">
							<input type="file" name="image" class="custom-file-input"
								id="validatedCustomFile" required> <label
								class="custom-file-label btn-outline-dark"
								for="validatedCustomFile">Choose file...</label>
						</div>
						<div class="input-group-append">
							<button class="btn btn-outline-primary" type="submit"
								id="inputGroupFile">Upload</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="row" style="margin-top: 20px; display: ${display};"
			id="copylink">
			<div class="col-md-8 col-sm-8">
				<input class="border-success" type="text" value="${link}"
					id="myInput" style="width: 80%; padding: 4px;" />
				<button class="btn btn-primary" onclick="myFunction()">Copy
					Link ảnh</button>
			</div>
		</div>
	</div>
	<script>
		// document.getElementById("inputGroupFile").onclick =function () {
		// document.getElementById("copylink").style.display = 'block';
		// };
		function myFunction() {
			/* Get the text field */
			var copyText = document.getElementById("myInput");
			/* Select the text field */
			copyText.select();
			copyText.setSelectionRange(0, 99999);
			/*For mobile devices*/
			/* Copy the text inside the text field */
			document.execCommand("copy");
			/* Alert the copied text */
			alert("Đã copy link hình: " + copyText.value);
		}

		$(document).on(
				'change',
				'.custom-file-input',
				function(event) {
					$(this).next('.custom-file-label').html(
							event.target.files[0].name);
				})
	</script>
</body>
</html>