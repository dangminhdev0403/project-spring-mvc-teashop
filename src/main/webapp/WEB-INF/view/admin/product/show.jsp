<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../layout/header.jsp" />
<div class="container">
  <div class="page-inner">
    <div class="page-header">
      <h3 class="fw-bold mb-3">Quản lí sản phẩm</h3>
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
          <a href="#">Quẩn lí sản phẩm</a>
        </li>
      </ul>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">
            <div class="d-flex align-items-center">
              <h4 class="card-title">Danh sách sản phẩm</h4>
              <a
                href="/admin/product/create"
                class="btn btn-primary btn-round ms-auto"
              >
                <i class="fa fa-plus"></i>
                Thêm mới sản phẩm
              </a>
            </div>
          </div>
          <div class="card-body">
            <!-- Modal -->

            <div class="table-responsive">
              <table
                id="add-row3"
                class="display table table-striped table-hover datatable-common"
              >
                <thead>
                  <tr>
                    <th>Mã SP</th>
                    <th>Tên</th>
                    <th>Danh mục</th>
                    <th>Giá(đã nhân hệ số)</th>
                    <th>Số lượng</th>
                    <th>Trạng thái</th>
                    <th style="width: 10%">Action</th>
                  </tr>
                </thead>

                <tbody>
                  <c:forEach var="product" items="${listProducts}">
                    <tr>
                      <td>${product.sku}</td>
                      <td>${product.name}</td>
                      <td>${product.category.name}</td>
                      <td>
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
                      </td>
                      <td>${product.stock}</td>
                      <td >
                        <c:choose>
                          <c:when test="${product.deletedAt != null}">
                           Tạm ẩn
                          </c:when>
                          <c:otherwise>Đang hiển thị </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <div class="form-button-action">
                          <a
                            href="/admin/product/update/${product.product_id}"
                            data-bs-toggle="tooltip"
                            title=""
                            class="btn btn-link btn-primary btn-lg"
                            data-original-title="Edit Task"
                          >
                            <i class="fa fa-edit"></i>
                          </a>
                          <a
                            href="/admin/product/delete/${product.product_id}"
                            data-bs-toggle="tooltip"
                            title=""
                            class="btn btn-link btn-danger is-delete"
                            data-original-title="Remove"
                          >
                            <i
                              class="fa fa-times"
                            ></i>
                          </a>
                          <c:choose>
                            <c:when test="${product.deletedAt != null}">
                              <a
                                class="btn btn-link btn-primary btn-lg "
                                href="/admin/product/unlock/${product.product_id}"
                              >
                                <i class="fas fa-lock-open"></i>
                              </a>
                            </c:when>
                            <c:otherwise>
                              <!-- lock -->
                              <a
                                class="btn btn-link btn-primary btn-lg "
                                href="/admin/product/lock/${product.product_id}"
                              >
                                <i class="fas fa-lock"></i>
                              </a>
                            </c:otherwise>
                          </c:choose>
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
