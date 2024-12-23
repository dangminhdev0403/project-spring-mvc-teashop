<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Header -->
<jsp:include page="../layout/header.jsp" />
<!-- end Header -->

<!-- MAIN -->
<main class="profile">
  <div class="container">
    <!-- Search bar -->
   

    <!-- Profile content -->
    <div class="profile-container">
      <div class="row gy-md-3">
        <jsp:include page="../layout/sidebar-profile.jsp" />

        <div class="col-9 col-xl-8 col-lg-7 col-md-12-1">
          <div class="cart-info">
            <h1 class="cart-info__heading">Quản lí dịa điểm nhận hàng</h1>
            <div class="cart-info__separate"></div>

            <!-- Checkout address -->
            <div class="user-address">
              <div class="user-address__top">
                <div>
                  <h2 class="user-address__title">Thêm địa chỉ nhận hàng</h2>
                  <p class="user-address__desc">
                    Bạn muốn nhận đơn hàng ở đâu?
                  </p>
                </div>
                <button
                  class="user-address__btn btn btn--primary btn--rounded btn--small js-toggle"
                  toggle-target="#add-new-address"
                >
                  <img src="/client/assets/icons/plus.svg" alt="" />
                  Thêm địa chỉ mới
                </button>
              </div>
              <div class="user-address__list">
                <!-- Empty message -->
                <!-- <p class="user-address__message">
                                    Not address yet.
                                    <a class="user-address__link js-toggle" href="#!" toggle-target="#add-new-address">Add a new address</a>
                                </p> -->
                <div class="cart-info__separate"></div>

                <!-- Address card 1 -->
                <c:if test="${empty addresses}">
                  <p>Danh sách địa chỉ đang trống.</p>
                </c:if>
                <c:if test="${not empty addresses}">
                  <c:forEach var="adr" items="${addresses}" varStatus="sAd">
                    <article class="address-card">
                      <div class="address-card__left">
                        <div class="address-card__choose">
                          <label class="cart-info__checkbox">
                           
                          </label>
                        </div>
                        <div class="address-card__info">
                          <h3 class="address-card__title">
                            ${adr.receiverName}
                          </h3>
                          <p class="address-card__desc"></p>
                          <ul class="address-card__list">
                            <li class="address-card__list-item">
                              SĐT: ${adr.receiverPhone}
                            </li>
                            <li class="address-card__list-item">
                              Địa chỉ: ${adr.receiverLocation}
                            </li>
                          </ul>
                        </div>
                      </div>
                      <div class="address-card__right">
                        <div class="cart-item__ctrl" style="min-height: 55%">
                          <button
                            class="js-toggle cart-item__ctrl-btn"
                            toggle-target="#update-address-${adr.id}"
                          >
                            <img
                              class="icon"
                              src="/client/assets/icons/edit.svg"
                              alt=""
                            />
                            Sửa
                          </button>

                          <form action="/delete-address" method="post">
                            <input
                            type="hidden"
                            name="${_csrf.parameterName}"
                            value="${_csrf.token}"
                          />
                          <input type="hidden" value="${adr.id}" name ="adrID">
                            <button
                              type="submit"
                        
                            class="cart-item__ctrl-btn is-delete"
                            style="
                              color: rgba(223, 132, 107, 0.973);
                              justify-content: space-evenly;
                            "
                            toggle-target="#delete-confirm"
                          >
                            <i class="fas fa-trash"></i>
                            <!-- Tăng kích thước gấp đôi -->
                            Xoá
                          </button>
                          </form>
                         
                        </div>
                      </div>
                    </article>
                  </c:forEach>
                </c:if>
              </div>
            </div>
          </div>
          
           <!--  -->
        </div>

       
      </div>
    </div>
  </div>
</main>



<div id="add-new-address" class="modal hide" style="--content-width: 650px">
  <div class="modal__content">
    <form:form action="/add-address" class="form" modelAttribute ="newAddress">
      <input
      type="hidden"
      name="${_csrf.parameterName}"
      value="${_csrf.token}"
    />
      <h2 class="modal__heading">Thêm địa chỉ giao hàng mới</h2>
      <div class="modal__body">
        <div class="form__row">
          <div class="form__group">
            <label for="name" class="form__label form__label--small"
              >Họ và tên</label
            >
            <div class="form__text-input form__text-input--small">
              <form:input
                type="text"
                name="name"
                path="receiverName"
                id="name"
                placeholder="Họ và tên"
                class="form__input receiverName"

              />
              <img
                src="client/assets/icons/form-error.svg"
                alt=""
                class="form__input-icon-error"
              />
            </div>

          </div>
          <div class="form__group">
            <label for="phone" class="form__label form__label--small"
              >Số điện thoại</label
            >
            <div class="form__text-input form__text-input--small">
              <form:input
                type="tel"
                name="phone receiverPhone"
                id="phone"
                path="receiverPhone"

                placeholder="Số điện thoại"
                class="form__input receiverPhone"
              />
              <img
                src="client/assets/icons/form-error.svg"
                alt=""
                class="form__input-icon-error"
              />
            </div>
          </div>
        </div>
        <div class="form__group grid" style="padding: 2rem 0 0 0;">
          <!-- <div class="form__text-input form__text-input--small address-group grid" > -->

 
            <!-- Select dialog -->
            <form:select class="css_select tinh form__text-input " id="tinh" name="tinh" title="Chọn Tỉnh Thành" style="text-align: center; cursor: pointer; padding: 0;" path="cityId">
              <form:option value="0" style="cursor: pointer;">Tỉnh Thành</form:option>
              <!-- Các tùy chọn tỉnh thành sẽ được thêm vào đây -->
          </form:select>
      
          <form:select class="css_select quan form__text-input" id="quan" name="quan" title="Chọn Quận Huyện" style="text-align: center; cursor: pointer; padding: 0;" path="districtId">
              <form:option value="0" style="cursor: pointer;">Quận Huyện</form:option>
              <!-- Các tùy chọn quận huyện sẽ được thêm vào đây -->
          </form:select>
      
          <form:select class="css_select phuong form__text-input form__text-input--large" id="phuong" name="phuong" title="Chọn Phường Xã" style="text-align: center;cursor: pointer; padding: 0;" path="wardId">
              <form:option value="0" style="cursor: pointer;">Phường Xã</form:option>
              <!-- Các tùy chọn phường xã sẽ được thêm vào đây -->
          </form:select>
          
          </div>


         
        
        
        <!-- </div> -->




        <div class="form__group">
          <label for="address" class="form__label form__label--small"
            >Địa chỉ người nhận</label
          >
          <div class="form__text-area">
            <form:textarea
              name="address"
              path="address"
              id="address"
              placeholder="Địa chỉ (Khu vực và đường)"
              class="form__text-area-input address"
            ></form:textarea>
            <img
              src="client/assets/icons/form-error.svg"
              alt=""
              class="form__input-icon-error"
            />
          </div>
        </div>
      
      
      </div>
      <div class="modal__bottom">
        <a
          class="btn btn--small btn--text modal__btn js-toggle"
          style="cursor: pointer;"
          toggle-target="#add-new-address"
        >
          Hủy
        </a>
        <button
        
          
          class="btn btn--small btn--primary modal__btn btn--no-margin  " id="add-address"
        >
          Tạo
        </button>

      </div>
    </form:form>
  </div>
  <div class="modal__overlay"></div>
</div>

<!-- update address -->
<c:if test="${not empty addresses}">
  <c:forEach var="address" items="${addresses}" >

  <div id="update-address-${address.id}" class="modal hide" style="--content-width: 650px">
    <div class="modal__content">
      <form action="/update-address" class="form address" method="post">
        <input
        type="hidden"
        name="${_csrf.parameterName}"
        value="${_csrf.token}"
      />

      <input type="hidden" name="idAddress" value="${address.id}">
        <h2 class="modal__heading">Cập nhật chỉ giao hàng </h2>
        <div class="modal__body">
          <div class="form__row">
            <div class="form__group">

              <label for="name" class="form__label form__label--small"
                >Họ và tên</label
              >
              <div class="form__text-input form__text-input--small">
                <input
                  type="text"
                  name="receiverName"
                  id="name"
                  placeholder="Họ và tên"
                  class="form__input receiverName "
                 
                value="${address.receiverName}"
                />
                <img
                  src="client/assets/icons/form-error.svg"
                  alt=""
                  class="form__input-icon-error"
                />

              </div>
              <p class="form__error">Họ Tên phải nhập trên 2 kí tự</p>

            </div>
            <div class="form__group">
              <label for="phone" class="form__label form__label--small"
                >Số điện thoại</label
              >
              <div class="form__text-input form__text-input--small">
                <input
                  type="tel"
                  name="receiverPhone"
                  id="phone"
                  value="${address.receiverPhone}"
  
                  placeholder="Số điện thoại"
                  class="form__input receiverPhone"
                  
                />
                <img
                  src="client/assets/icons/form-error.svg"
                  alt=""
                  class="form__input-icon-error"
                />
              </div>
            </div>
          </div>
          <div class="form__group grid" style="padding: 2rem 0 0 0;">
            <!-- <div class="form__text-input form__text-input--small address-group " > -->
            
   
              <!-- Select dialog -->
              <select data-city-id ="${address.cityId}" class="css_select tinh form__text-input  update"  name="city" title="Chọn Tỉnh Thành" style="text-align: center; cursor: pointer; padding: 0;" path="city">
               
                <!-- Các tùy chọn tỉnh thành sẽ được thêm vào đây -->
              </select>
        
            <select data-district-id ="${address.districtId}" class="css_select quan form__text-input update"  name="district" title="Chọn Quận Huyện" style="text-align: center; cursor: pointer; padding: 0;" path="district">
              <option value="${address.districtId}" style="cursor: pointer;"  class="firtsOption" quanid ="${address.districtId}"></option>


                <!-- Các tùy chọn quận huyện sẽ được thêm vào đây -->
            </select>
        
            <select data-ward-id ="${address.wardId}" class="css_select phuong form__text-input form__text-input--large update"  name="ward" title="Chọn Phường Xã" style="text-align: center; cursor: pointer; padding: 0;" path="ward">
              <option value="${address.wardId}" style="cursor: pointer;"  class="firtsOption"></option>
                <!-- Các tùy chọn phường xã sẽ được thêm vào đây -->
            </select>

            <!-- Select dialog -->
          


            </div>
          <!-- </div> -->
  
  
  
  
          <div class="form__group">
            <label for="address" class="form__label form__label--small"
              >Địa chỉ người nhận</label
            >
            <div class="form__text-area">
              <textarea
                name="address"
                id="address"
                placeholder="Địa chỉ (Khu vực và đường)"
                value ="address.address"
                class="form__text-area-input address"
               
              >${address.address}</textarea>
             
            </div>
          </div>
        
        
        </div>
        <div class="modal__bottom">
          <a 
            class="btn btn--small btn--text modal__btn js-toggle"
            style="cursor: pointer;"

            toggle-target="#update-address-${address.id}"
          >
            Hủy
          </a>
          <button
          
            
            class="btn btn--small btn--primary modal__btn btn--no-margin "
          >
            Sửa
          </button>
  
        </div>
      </form>
    </div>
    <div class="modal__overlay"></div>
  </div>
    </c:forEach>
    </c:if>

<!-- Footer -->
<jsp:include page="../layout/footer.jsp" />

<!--end footer  -->
