<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="../layout/header.jsp" />
<div class="container">
  <div class="page-inner">
    <div class="page-header">
      <h3 class="fw-bold mb-3">Phương thức thanh toán</h3>
      <ul class="breadcrumbs mb-3">
        <li class="nav-home">
          <a href="#">
            <i class="icon-home"></i>
          </a>
        </li>
        <li class="separator">
          <i class="icon-arrow-right"></i>
        </li>
        <li class="nav-item">
          <a href="/admin/payment">Phương thức thanh toán</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="d-flex align-items-center">
              <h4 class="card-title">Danh sách thanh toán</h4>
              <a
                href="/admin/payment/create"
                class="btn btn-primary btn-round ms-auto"
              >
                <i class="fa fa-plus"></i>
                Thêm mới thanh toán
              </a>
            </div>
          </div>
          <div class="card-body">
            <!-- Modal -->

            <div class="table-responsive">
              <table
                id="add-row1"
                class="display table table-striped table-hover datatable-common"
              >
                <thead>
                  <tr>
                    <th>STT</th>
                    <th>Tên</th>
                    <th>Giá</th>
                    <th>Trạng thái</th>
                  
                    <th style="width: 10%">Thao tác</th>
                  </tr>
                </thead>

                <tbody>
                  <c:forEach
                    var="pay"
                    items="${listPay}"
                    varStatus="status"
                  >
                    <tr>
                      <td>${status.index + 1}</td>
                      <td>${pay.name}</td>
                      <td class ="format-price">${pay.price}</td>
                      <td>
                        <c:if test = "${pay.status == true}"> 
                          Đang hiển thị
                        </c:if>
                        
                        <c:if test = "${pay.status != true}"> 
                          Đang ẩn
                        </c:if>
                      
                      </td>
                     
                      <td>
                        <div class="form-button-action">
                          <a
                            href="/admin/payment/update/${pay.id}"
                            data-bs-toggle="tooltip"
                            title=""
                            class="btn btn-link btn-primary btn-lg"
                            data-original-title="Edit Task"
                          >
                            <i class="fa fa-edit"></i>
                          </a>
                          <a
                            href="/admin/payment/delete/${pay.id}"
                            data-bs-toggle="tooltip"
                            title=""
                            class="btn btn-link btn-danger"
                            data-original-title="Remove"
                          >
                            <i class="fa fa-times"></i>
                          </a>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../layout/footer.jsp" />