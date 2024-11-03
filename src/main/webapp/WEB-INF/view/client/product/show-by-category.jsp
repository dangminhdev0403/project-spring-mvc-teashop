<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />

<!-- end Header -->

<!-- MAIN -->
<main class="container home">
  <!-- Browse Products -->
  <section class="home__container">
    <div class="row">
      <div class="col-12 col-md-4 g-3 ">
        <form> 
        <div class="row">
         
          <div class="col-6 col-md-12 " id="targetFilter">
            <div class="mb-2"><b>Sắp xếp</b></div>
            <div class="form-check form-check-inline">
              
              <input class="form-check-input" type="radio" id="target-0"   name ="sort" checked/>
              <label class="form-check-label" for="target-0" > Không</label>
            </div>  
            <div class="form-check form-check-inline">

              <input class="form-check-input" type="radio" id="target-1" value="asc"  name ="sort"/>
              <label class="form-check-label" for="target-1">Giá thấp lên cao</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" id="target-2" value="desc" name ="sort" />
              <label class="form-check-label" for="target-2">Giá cao xuống thấp</label>
            </div>
            
           
          </div>
          <div class="col-6 col-md-12" id="targetFilter">
            <div class="mb-2"><b>Mức giá</b></div>
            <div class="form-check form-check-inline">
              
              <input class="form-check-input" type="radio"   name ="price" checked/>
              <label class="form-check-label"  >Không</label>
            </div> 
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" id="target-3" value="0-50" name = "price"/>
              <label class="form-check-label" for="target-3">Dưới 50.000đ</label>
            </div>

            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" id="target-4" value="100-300"  name = "price"/>
              <label class="form-check-label" for="target-4">100.000đ - 300.000đ</label>
            </div>
            <div class="form-check form-check-inline">
              <input class="form-check-input" type="radio" id="target-5" value="200-500"  name = "price"/>
              <label class="form-check-label" for="target-5">200.000đ - 500.000đ</label>
            </div>
           

          </div>

          <div class="col-12">
            <button class="btn btn-filter mb-4" id="btnFilter">
                Lọc Sản Phẩm
            </button>
        </div>
      
        </div>

      </div>
    </form>
      <div class="row row-cols-3 row-cols-lg-2 row-cols-sm-1 g-3  col-md-8 col-12 ">
        <!-- Product card 1
        <div class="col">
          <article class="product-card">
            <div class="product-card__img-wrap">
              <a href="./product-detail.html">
                <img src="./assets/img/product/item-1.png" alt="" class="product-card__thumb" />
              </a>
              <button class="like-btn product-card__like-btn">
                <img src="./assets/icons/heart.svg" alt="" class="like-btn__icon icon" />
                <img src="./assets/icons/heart-red.svg" alt="" class="like-btn__icon--liked" />
              </button>
            </div>
            <h3 class="product-card__title">
              <a href="./product-detail.html">Coffee Beans - Espresso Arabica and Robusta Beans</a>
            </h3>
            <p class="product-card__brand">Lavazza</p>
            <div class="product-card__row">
              <span class="product-card__price">$47.00</span>
              <img src="./assets/icons/star.svg" alt="" class="product-card__star" />
              <span class="product-card__score">4.3</span>
            </div>
          </article>
        </div> -->

          <!-- động -->
      <c:forEach var="product" items="${listProduct}">
        <div class="col">
          <article class="product-card">
            <div class="product-card__img-wrap">
              <a href="/product/${product.product_id}">
                <img
                  src="/upload/products/${product.productImages[0].name}"
                  alt="${product.productImages[0].name}"
                  class="product-card__thumb"
                />
              </a>
            </div>
            <h3 class="product-card__title">
              <a href="/product/${product.product_id}"> ${product.name}</a>
            </h3>
            <p class="product-card__brand">${product.category.name}</p>
            <div class="product-card__row">
              <span class="product-card__price">
                <c:choose>
                  <c:when test="${product.price != null}">
                    <c:if test="${product.price % 1 != 0}">
                      <fmt:formatNumber
                        value="${product.price}"
                        pattern="#,##0.000"
                      />
                      đ
                    </c:if>
                    <c:if test="${product.price % 1 == 0}">
                      <fmt:formatNumber
                        value="${product.price}"
                        pattern="#,##0"
                      />
                      đ
                    </c:if>
                  </c:when>
                </c:choose>
              </span>

              <img
                src="/client/assets/icons/star.svg"
                alt=""
                class="product-card__star"
              />
              <span class="product-card__score">4.3</span>
            </div>
          </article>
        </div>
      </c:forEach>

        

    


      
      </div>
    </div>
    <div class="pagination d-flex justify-content-center mt-5">
      
      <c:if test="${ currentPage > 1 }">
        <li class="page-item">
          <a class="disabled page-link" href="?page=${currentPage -1 }" aria-label="Previous">
            <span aria-hidden="true">«</span>
          </a>
        </li>
      </c:if>

      <c:forEach begin="0" end="${totalPages }" varStatus="loop">
        <li class="page-item">
          <a
            class="page-link ${(loop.index+1) eq currentPage ? 'active' : ''}"
            href="?page=${loop.index+1}"
          >
            ${loop.index+1}
          </a>
        </li>
      </c:forEach>

      <c:if test="${ currentPage == totalPages  }">
        <li class="page-item">
          <a class="disabled page-link" href="?page=${currentPage +1 }" aria-label="Next">
            <span aria-hidden="true">»</span>
          </a>
        </li>
</c:if>
     
    </div>
  
  </section>
</main>

<!-- Footer -->

<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->