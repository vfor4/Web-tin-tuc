<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<base href="${pageContext.servletContext.contextPath}/">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css"
	href="resources/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/blog-home.css">
<script type="text/javascript"
	src="resources/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<title>Tác giả</title>
</head>
<body>
	<!-- nav -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="home.htm"> <img
				src="resources/images/HomePage.png" style="height: 45px;">
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse " id="navbarResponsive">
				<ul class="navbar-nav ml-auto" style="font-size: 20px;">
					<li class="nav-item active"><a class="nav-link "
						href="home.htm" style="margin-right: 15px;">TRANG CHỦ <span
							class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item dropdown dmenu"><a
						class="nav-link dropdown-toggle" href="#" id="navbardrop"
						data-toggle="dropdown"> Danh Mục </a>
						<div class="dropdown-menu sm-menu">
							<c:forEach items="${categoryItem }" var="category">
								<a class="dropdown-item"
									href="home/category/${category.maDanhMuc }.htm">${category.tenDanhMuc }</a>
							</c:forEach>
						</div></li>
					<li class="nav-item "><a class="nav-link" href="register.htm">ĐĂNG
							KÍ CỘNG TÁC</a></li>
					<li class="nav-item "><a class="nav-link"
						href="home/author.htm">TÁC GIẢ</a></li>

				</ul>
			</div>
		</div>
	</nav>
	<!-- nav -->
	<div class="container">
		<div style="margin-top: 60px;" class="page-header">
			<div class="container">
				<div class="row">
					<div class="col-md-offset-1 col-md-10 text-center">
						<h1 class="text-uppercase">Về Tác Giả</h1>
						<p class="lead">Hiện đang theo học tại Học viện công nghệ bưu
							chính viễn thông chuyên ngành an toàn thông tin.Là một người
							thích viết, tác giả muốn chia sẻ với mọi người những bài học
							những góc nhìn của mình về học tập, những suy nghĩ, cuộc sống tại
							học viện, các hoạt động tại học viện.</p>
					</div>
				</div>
			</div>
		</div>
		<!-- row -->
		<div class="row">
			<div class="col-md-5">
				<div class="section-row">
					<div class="section-title">
						<h2 class="title">Câu chuyện của bản thân</h2>
					</div>
					<p>Cuộc sống này là của bạn, con đường đang đi cũng chính do
						bản thân mình chọn. Dù có khó khăn như thế nào thì cũng phải cố mà
						bước đi. Bạn biết đấy, nếu không bước về phía trước thì bạn sẽ
						chẳng bao giờ biết được con đường đó có những gì đang đợi bạn.
						Không phải lựa chọn nào cũng đúng, không phải việc gì cũng thành
						công, chỉ có tiếp tục bước mới biết được, vì nếu không ngay cả
						nhận lại thất bại bạn còn không có tư cách chứ đừng nói gì hai chữ
						thành công.</p>
					<blockquote class="blockquote">
						<p>Hãy vận dụng hết những kỹ năng phát triển bản thân của bạn
							để giải quyết một vấn đề nào đó. Cho dù là đi làm tình nguyện tại
							trung tâm người vô gia cư tại địa phương hay tham gia một chuyến
							đi sứ mệnh tới nước khác, hoặc kể cả học cách sử dụng một thiết
							bị nào đó. Đó là cách bạn đang khiến mình linh hoạt và đặc biệt
							hơn.</p>
						<footer class="blockquote-footer">Mango</footer>
					</blockquote>
				</div>
			</div>
			<div class="col-md-7">
				<div class="section-row">
					<div class="section-title">
						<h2 class="title">Sự phát triển của trang</h2>
					</div>
					<p>Có một con người đặc biệt ở trong bạn. Để cả thế giới thấy
						được con người ấy, bạn phải đối mặt với nỗi sợ hãi của mình. Nỗi
						sợ hãi sẽ chèn ép sự sáng tạo và nhạy bén có sẵn trong mỗi chúng
						ta. Chúng khiến ta chỉ ở trong vùng an toàn của mình. Nếu bạn muốn
						thể hiện, phát triển bản thân mình, phát huy sức mạnh một cách tốt
						nhất, bạn phải thoát khỏi nỗi sợ đó, đặc biệt là những nỗi sợ
						khiến bạn thụt lùi.</p>
					<p>Tìm ra tiếng nói của mình. Đưa ra những triết lý của bản
						thân. Tìm một loại hình nghệ thuật hoặc một góc sáng tạo phù hợp
						với tính cách của bạn, không ngừng phát triển bản thân mình. Bạn
						thích viết lách? Hãy mở một trang blog. Bạn thích đọc? Hãy tham
						gia một câu lạc bộ sách. Từng ngày qua, bạn trở nên mới mẻ và cuốn
						hút hơn.</p>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/home/Footer.jsp"></jsp:include>
</body>
</html>