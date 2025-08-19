<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<%@ include file="all_component/all_css.jsp"%>

<title>Admin - Add New Items Page</title>
<style>
#imagePreview {
    max-width: 100%; 
    max-height: 180px; 
    object-fit: contain; 
    border: 1px solid #dee2e6;
    padding: 4px;
    border-radius: 4px;
    display: block;
}

.hidden {
    display: none !important;
}
</style>
</head>

<body>
    <%@ include file="all_component/navbar.jsp"%>
    <!-- Navbar include -->

    <div class="container mt-4">
        <div class="row">
            <div class="col">
                <div class="card shadow">
                    <div class="card-body">
                        <h4 class="card-title mb-4">Add New Items</h4>

                        <!-- Display error messages from backend -->
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">${error}</div>
                        </c:if>

                        <!-- Display success messages from backend -->
                        <c:if test="${not empty success}">
                            <div class="alert alert-success" role="alert">${success}</div>
                        </c:if>

                        <hr>

                        <!-- Form to add a new item -->
                        <form action="add_new_item" method="post" id="add_new_item"
                            enctype="multipart/form-data" 
                            novalidate class="needs-validation">

                            <!-- Item Name and Description -->
                            <fieldset class="pb-3 mb-3">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label for="name" class="form-label"><strong>Name:</strong></label>
                                        <input id="name" name="name" type="text" class="form-control"
                                            required aria-required="true" />
                                        <div class="invalid-feedback">Name is required.</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="description" class="form-label"><strong>Description:</strong></label>
                                        <input id="description" name="description" type="text"
                                            class="form-control" required />
                                        <div class="invalid-feedback">Description is required.</div>
                                    </div>
                                </div>
                            </fieldset>
                            <hr>

                            <!-- Category selection and image upload -->
                            <fieldset class="pb-3 mb-3">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <label for="category" class="form-label"><strong>Category:</strong></label>
                                        <select id="category" name="category"
                                            class="form-select form-select-sm" required
                                            aria-describedby="categoryFeedback" aria-required="true">
                                            <option value="">-- Select --</option>
                                            <option value="school_book">School Book</option>
                                            <option value="pen_pencil">Pen/Pencil</option>
                                            <option value="pencil_sharpener">Pencil Sharpener</option>
                                            <option value="eraser">Eraser</option>
                                            <option value="school_bag">School Bag</option>
                                            <option value="other">Other</option>
                                        </select>
                                        <div id="categoryFeedback" class="invalid-feedback">
                                            Please select a category.
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <label for="image" class="form-label"><strong>Item Image:</strong></label> 
                                        <input id="image" name="image" type="file"
                                            class="form-control form-control-sm"
                                            accept="image/png, image/jpeg" required aria-describedby="imageHelp" />
                                        <div id="imageHelp" class="form-text">Allowed: JPG/PNG. Max size: 2MB. Preview below.</div>
                                        <div class="invalid-feedback">Please upload an image.</div>
                                    </div>

                                    <!-- Image preview and size error -->
                                    <div class="col-md-4">
                                        <div class="mt-2">
                                            <c:choose>
                                                <c:when test="${not empty param.existing_image_url}">
                                                    <img id="imagePreview" alt="Selected image preview"
                                                        src="<c:out value='${param.existing_image_url}'/>" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img id="imagePreview" alt="Selected image preview"
                                                        class="hidden" />
                                                </c:otherwise>
                                            </c:choose>
                                            <div id="imageSizeError"
                                                class="text-danger small visually-hidden">Image too large. Maximum allowed is 2MB.</div>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            <hr>

                            <!-- Price and Stock Quantity -->
                            <fieldset class="pb-3 mb-3">
                                <div class="row g-3">
                                    <div class="col-md-3">
                                        <label for="price" class="form-label"><strong>Price:</strong></label>
                                        <div class="input-group input-group-sm">
                                            <span class="input-group-text">RS</span> 
                                            <input id="price" name="price" type="number" step="0.01" 
                                                class="form-control" required min="0"
                                                oninvalid="this.setCustomValidity('Please provide a valid price (>= 0).')"
                                                oninput="setCustomValidity('')"
                                                aria-describedby="priceFeedback" aria-required="true" />
                                                 <div id="priceFeedback" class="invalid-feedback">
                                            Please provide a valid price.
                                        </div>
                                        </div>
                                       
                                    </div>

                                    <div class="col-md-2">
                                        <label for="stock_quantity" class="form-label"><strong>Stock Quantity:</strong></label> 
                                        <input id="stock_quantity" name="stock_quantity"
                                            type="number" class="form-control form-control-sm" required
                                            min="0" 
                                            oninvalid="this.setCustomValidity('Please provide stock quantity (>= 0).')"
                                            oninput="setCustomValidity('')"
                                            aria-describedby="stockFeedback" aria-required="true" />
                                        <div id="stockFeedback" class="invalid-feedback">
                                            Please provide stock quantity.
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            <hr>

                            <!-- Hidden field for action -->
                            <input type="hidden" id="action" name="action" value="add" />

                            <!-- Submit button -->
                            <button type="submit" class="btn btn-info">Add</button>
                        </form>
                        <!-- End Form -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="all_component/footer.jsp"%>

    <!-- Image Preview + Bootstrap Validation Script -->
    <script>
        (function() {
            const form = document.getElementById('add_new_item');
            const imageInput = document.getElementById('image');
            const preview = document.getElementById('imagePreview');
            const sizeError = document.getElementById('imageSizeError');
            const MAX_SIZE = 2 * 1024 * 1024; // 2MB

            // Bootstrap validation
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);

            // Event listener for image selection
            imageInput.addEventListener('change', function() {
                sizeError.classList.add('visually-hidden'); 
                const file = this.files[0];
                if (!file) return;

                if (file.size > MAX_SIZE) { 
                    sizeError.classList.remove('visually-hidden');
                    preview.classList.add('hidden'); 
                    preview.removeAttribute('src');
                } else {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        preview.src = e.target.result;
                        preview.classList.remove('hidden');
                    };
                    reader.readAsDataURL(file);
                }
            });
        })();
    </script>
</body>
</html>
