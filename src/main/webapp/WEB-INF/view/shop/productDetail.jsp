<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>

<%@ include file="../include/header.jspf" %>

<section class="single-product">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<ol class="breadcrumb">
					<li><a href="<%=request.getContextPath()%>/index.do">Home</a></li>
					<li><a href="<%=request.getContextPath()%>/shop/all.do">Shop</a></li>
					<li class="active">Single Product</li>
				</ol>
			</div>
		</div>


		<%
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";

		Connection con = null;
		PreparedStatement pstmt = null;

		ResultSet rs = null;

		String typecode, pname, brand, thumbnail, image;
		int price;
		String sql;

		request.setCharacterEncoding("UTF-8");
		int getpId = Integer.parseInt(request.getParameter("pId"));
		

		try {
		    Class.forName(driver);
		    con = DriverManager.getConnection(url, "MEALKIT", "MEALKIT");

		    sql = "SELECT * FROM product where pid=?";
		    pstmt = con.prepareStatement(sql);
		    pstmt.setInt(1, getpId);
		    rs = pstmt.executeQuery();

		    while (rs.next()) {
		%>
		


		<div class="row mt-20">
			<div class="col-md-5">
				<div class="single-product-slider">
					<div id='carousel-custom' class='carousel slide'
						data-ride='carousel'>
						<div class='carousel-outer'>
							<!-- me art lab slider -->
							<div class='carousel-inner '>
								<div class='item active'>
									<img src='<%=request.getContextPath()%><%=rs.getString("thumbnail")%>' alt='' />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-7">
				<div class="single-product-details">
					<h2><%=rs.getString("pname")%></h2>
					<p class="product-price"><%=rs.getInt("price")%></p>

					<p class="product-description mt-20">나중에 설명 넣을 자리</p>
					<div class="product-category">
						<span>브랜드</span> <%=rs.getString("brand")%>
					</div>
					<div class="product-category">
						<span>배송구분</span> 택배배송: 3,000원
					</div>
					<div class="product-quantity">
						<span>주문 수량</span>
						<div class="product-quantity-slider">
							<input id="product-quantity" type="text" value="0"
								name="product-quantity">
						</div>
					</div>
					<a href="cart.html" class="btn btn-main mt-20">Add To Cart</a>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-xs-12">
				<div class="tabCommon mt-20">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#details"
							aria-expanded="true">Details</a></li>
						<li class=""><a data-toggle="tab" href="#reviews"
							aria-expanded="false">Reviews (3)</a></li>
					</ul>
					<div class="tab-content patternbg">
						<div id="details" class="tab-pane fade active in">
							<h4>Product Description</h4>
							<img src='<%=request.getContextPath()%><%=rs.getString("image")%>'>
						</div>
						<div id="reviews" class="tab-pane fade">
							<div class="post-comments">
								<ul class="media-list comments-list m-bot-50 clearlist">
									<!-- Comment Item start-->
									<li class="media"><a class="pull-left" href="#!"> <img
											class="media-object comment-avatar"
											src="images/blog/avater-1.jpg" alt="" width="50" height="50" />
									</a>

										<div class="media-body">
											<div class="comment-info">
												<h4 class="comment-author">
													<a href="#!">Jonathon Andrew</a>

												</h4>
												<time datetime="2013-04-06T13:53">July 02, 2015, at
													11:34</time>
												<a class="comment-button" href="#!"><i
													class="tf-ion-chatbubbles"></i>Reply</a>
											</div>

											<p>Lorem ipsum dolor sit amet, consectetur adipiscing
												elit. Quisque at magna ut ante eleifend eleifend.Lorem ipsum
												dolor sit amet, consectetur adipisicing elit. Quod laborum
												minima, reprehenderit laboriosam officiis praesentium?
												Impedit minus provident assumenda quae.</p>
										</div></li>
									<!-- End Comment Item -->

									<!-- Comment Item start-->
									<li class="media"><a class="pull-left" href="#!"> <img
											class="media-object comment-avatar"
											src="images/blog/avater-4.jpg" alt="" width="50" height="50" />
									</a>

										<div class="media-body">

											<div class="comment-info">
												<div class="comment-author">
													<a href="#!">Jonathon Andrew</a>
												</div>
												<time datetime="2013-04-06T13:53">July 02, 2015, at
													11:34</time>
												<a class="comment-button" href="#!"><i
													class="tf-ion-chatbubbles"></i>Reply</a>
											</div>

											<p>Lorem ipsum dolor sit amet, consectetur adipiscing
												elit. Quisque at magna ut ante eleifend eleifend. Lorem
												ipsum dolor sit amet, consectetur adipisicing elit. Magni
												natus, nostrum iste non delectus atque ab a accusantium
												optio, dolor!</p>

										</div></li>
									<!-- End Comment Item -->

									<!-- Comment Item start-->
									<li class="media"><a class="pull-left" href="#!"> <img
											class="media-object comment-avatar"
											src="images/blog/avater-1.jpg" alt="" width="50" height="50">
									</a>

										<div class="media-body">

											<div class="comment-info">
												<div class="comment-author">
													<a href="#!">Jonathon Andrew</a>
												</div>
												<time datetime="2013-04-06T13:53">July 02, 2015, at
													11:34</time>
												<a class="comment-button" href="#!"><i
													class="tf-ion-chatbubbles"></i>Reply</a>
											</div>

											<p>Lorem ipsum dolor sit amet, consectetur adipiscing
												elit. Quisque at magna ut ante eleifend eleifend.</p>

										</div></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="products related-products section">
	<div class="container">
		<div class="row">
			<div class="title text-center">
				<h2>Related Products</h2>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div class="product-item">
					<div class="product-thumb">
						<span class="bage">Sale</span> <img class="img-responsive"
							src="images/shop/products/product-5.jpg" alt="product-img" />
						<div class="preview-meta">
							<ul>
								<li><span data-toggle="modal" data-target="#product-modal">
										<i class="tf-ion-ios-search"></i>
								</span></li>
								<li><a href="#"><i class="tf-ion-ios-heart"></i></a></li>
								<li><a href="#!"><i class="tf-ion-android-cart"></i></a></li>
							</ul>
						</div>
					</div>
					<div class="product-content">
						<h4>
							<a href="product-single.html">Reef Boardsport</a>
						</h4>
						<p class="price">$200</p>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="product-item">
					<div class="product-thumb">
						<img class="img-responsive"
							src="images/shop/products/product-1.jpg" alt="product-img" />
						<div class="preview-meta">
							<ul>
								<li><span data-toggle="modal" data-target="#product-modal">
										<i class="tf-ion-ios-search-strong"></i>
								</span></li>
								<li><a href="#"><i class="tf-ion-ios-heart"></i></a></li>
								<li><a href="#!"><i class="tf-ion-android-cart"></i></a></li>
							</ul>
						</div>
					</div>
					<div class="product-content">
						<h4>
							<a href="product-single.html">Rainbow Shoes</a>
						</h4>
						<p class="price">$200</p>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="product-item">
					<div class="product-thumb">
						<img class="img-responsive"
							src="images/shop/products/product-2.jpg" alt="product-img" />
						<div class="preview-meta">
							<ul>
								<li><span data-toggle="modal" data-target="#product-modal">
										<i class="tf-ion-ios-search"></i>
								</span></li>
								<li><a href="#"><i class="tf-ion-ios-heart"></i></a></li>
								<li><a href="#!"><i class="tf-ion-android-cart"></i></a></li>
							</ul>
						</div>
					</div>
					<div class="product-content">
						<h4>
							<a href="product-single.html">Strayhorn SP</a>
						</h4>
						<p class="price">$230</p>
					</div>
				</div>
			</div>
			<div class="col-md-3">
				<div class="product-item">
					<div class="product-thumb">
						<img class="img-responsive"
							src="images/shop/products/product-3.jpg" alt="product-img" />
						<div class="preview-meta">
							<ul>
								<li><span data-toggle="modal" data-target="#product-modal">
										<i class="tf-ion-ios-search"></i>
								</span></li>
								<li><a href="#"><i class="tf-ion-ios-heart"></i></a></li>
								<li><a href="#!"><i class="tf-ion-android-cart"></i></a></li>
							</ul>
						</div>
					</div>
					<div class="product-content">
						<h4>
							<a href="product-single.html">Bradley Mid</a>
						</h4>
						<p class="price">$200</p>
					</div>
				</div>
			</div>

		</div>
	</div>
</section>

<%
}
} catch (Exception e) {
System.out.println("데이터베이스 연결 실패!");
} finally {
try {
if (rs != null)
    rs.close();
if (pstmt != null)
    pstmt.close();
if (con != null)
    con.close();
} catch (Exception e) {
System.out.println(e.getMessage());
}
}
%>



<%@ include file="../include/footer.jspf" %>