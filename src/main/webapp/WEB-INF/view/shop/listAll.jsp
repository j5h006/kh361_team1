<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>

<%@ include file="../include/header.jspf" %>

<section class="products section bg-gray">
	<div class="container">
		<div class="row">
			<div class="title text-center">
				<h2>Lists of foods</h2>
			</div>
		</div>
		<div class="row">
		
		

		<% 
		        String driver = "oracle.jdbc.driver.OracleDriver";
		        String url = "jdbc:oracle:thin:@localhost:1521:XE";
		
		        Connection con = null;
		        PreparedStatement pstmt = null;
		        
		        ResultSet rs = null;
		
		        String typecode, pname, thumbnail; 
		        int pid, price;
		        String sql;
		        
		        try {
		            Class.forName(driver);
		            con = DriverManager.getConnection(url, "MEALKIT", "MEALKIT");
		
		            sql = "SELECT * FROM product ORDER BY pId DESC";
		
		            pstmt = con.prepareStatement(sql);
		            rs = pstmt.executeQuery(); 
		            
		            
		
		                        while (rs.next()) { %>
		<div class="col-md-4">
			<div class="product-item">
				<div class="product-thumb">
					<img class="img-responsive" src="<%=request.getContextPath()%><%=rs.getString("thumbnail")%>"
						alt="product-img" />
					<div class="preview-meta">
						<ul>
							<li>

							<a
									href="<%=request.getContextPath()%>/shop/detail.do?pId=<%=rs.getString("pid")%>"><i
										class="tf-ion-ios-search-strong"></i></a></li>
							<li><a href="#!"><i class="tf-ion-ios-heart"></i></a></li>
							<li><a href="#!"><i class="tf-ion-android-cart"></i></a></li>
						</ul>
					</div>
				</div>
				<div class="product-content">
					<h4>
						<a href="<%=request.getContextPath()%>/aviato/product-single.html"><%=rs.getString("pname")%></a>
					</h4>
					<p class="price"><%=rs.getInt("price")%></p>
				</div>
			</div>
		</div>
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
		
<%-- 		<!-- Modal -->
		<div class="modal product-modal fade" id="product-modal">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<i class="tf-ion-close"></i>
			</button>
		  	<div class="modal-dialog " role="document">
		    	<div class="modal-content">
			      	<div class="modal-body">
			        	<div class="row">
			        		<div class="col-md-8 col-sm-6 col-xs-12">
			        			<div class="modal-image">
				        			<img class="img-responsive" src="<%=request.getContextPath()%>/aviato/images/shop/products/modal-product.jpg" alt="product-img" />
			        			</div>
			        		</div>
			        		<div class="col-md-4 col-sm-6 col-xs-12">
			        			<div class="product-short-details">
			        				<h2 class="product-title">GM Pendant, Basalt Grey</h2>
			        				<p class="product-price">$200</p>
			        				<p class="product-short-description">
			        					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Rem iusto nihil cum. Illo laborum numquam rem aut officia dicta cumque.
			        				</p>
			        				<a href="cart.html" class="btn btn-main">Add To Cart</a>
			        				<a href="product-single.html" class="btn btn-transparent">View Product Details</a>
			        			</div>
			        		</div>
			        	</div>
			        </div>
		    	</div>
		  	</div>
		</div><!-- /.modal --> --%>

		</div>
	</div>
</section>


<%@ include file="../include/footer.jspf" %>