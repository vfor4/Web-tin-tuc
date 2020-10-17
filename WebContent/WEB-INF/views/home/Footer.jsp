<%@ page pageEncoding="utf-8"%>

<footer class="py-5 bg-dark">
		<div class="container">
		<p class="m-0 text-center text-white">${sessionScope.footer.name }</p>
		<p style="margin-left: 380px;" class="mb-0  text-white">Liên hệ: ${sessionScope.footer.phone }<a class="ml-5" href="${sessionScope.footer.urlFacebook }" target="_blank"><img alt="urlFB" src="resources/images/urlFacebook.png">FACEBOOK </a></p>
		<p style="margin-left: 380px;" class="mb-0 text-white">Địa chỉ: ${sessionScope.footer.address }</p>
		<p class="mb-0 text-center text-white">Copyright &copy; 2020</p>
		
		</div>
		<!-- /.container -->
</footer>
