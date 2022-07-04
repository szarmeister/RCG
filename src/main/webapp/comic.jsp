<%--@elvariable id="image_3_lockStateClass" type="java.lang.String"--%>
<%--@elvariable id="image_2_lockStateClass" type="java.lang.String"--%>
<%--@elvariable id="image_1_lockStateClass" type="java.lang.String"--%>

<%--@elvariable id="image_3_lockState" type="java.lang.String"--%>
<%--@elvariable id="image_2_lockState" type="java.lang.String"--%>
<%--@elvariable id="image_1_lockState" type="java.lang.String"--%>

<%--@elvariable id="image_3" type="java.lang.String"--%>
<%--@elvariable id="image_2" type="java.lang.String"--%>
<%--@elvariable id="image_1" type="java.lang.String"--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>RCG</title>
    <link rel="icon" href="icons/logo.png">
    <link rel="stylesheet" href="styles/comic_style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.js"></script>
    <script>
        function lockImage(lockId, className) {
            const element = document.getElementById(lockId);

            if (className === 'fa-solid fa-lock-open') {
                element.className = 'fa-solid fa-lock';
            } else {
                element.className = 'fa-solid fa-lock-open';
            }

            const elements = document.getElementsByName(lockId);
            elements.forEach(element => {
                element.value === 'no' ? element.value = 'yes' : element.value = 'no';
                console.log(element.value);
            });
        }
    </script>
</head>
<body>

<div class="title">Random Comic Generator</div>
<div class="main">
    <form class="comic_generator" action="generate_comics" method="get">
        <table class="comic_generator">
            <tr class="lock_icon_row">
                <td class="lock_icon">
                    <i id="image_lock_1" class="${empty image_1_lockStateClass ? 'fa-solid fa-lock-open' : image_1_lockStateClass}" onclick="lockImage(this.id, this.className)"></i>
                    <input hidden name="image_lock_1" value="${empty image_1_lockState ? 'no' : image_1_lockState}">
                </td>
                <td class="lock_icon">
                    <i id="image_lock_2" class="${empty image_2_lockStateClass ? 'fa-solid fa-lock-open' : image_2_lockStateClass}" onclick="lockImage(this.id, this.className)"></i>
                    <input hidden name="image_lock_2" value="${empty image_2_lockState ? 'no' : image_2_lockState}">
                </td>
                <td class="lock_icon">
                    <i id="image_lock_3" class="${empty image_3_lockStateClass ? 'fa-solid fa-lock-open' : image_3_lockStateClass}" onclick="lockImage(this.id, this.className)"></i>
                    <input hidden name="image_lock_3" value="${empty image_3_lockState ? 'no' : image_3_lockState}">
                </td>
            </tr>
            <tr class="image_row">
                <td class="image">
                    <img src="images/${empty image_1 ? '1.png' : image_1}" alt="Image is missing">
                    <input hidden name="image_1" value="${empty image_1 ? '1.png' : image_1}">
                </td>
                <td class="image">
                    <img src="images/${empty image_2 ? '2.png' : image_2}" alt="Image is missing">
                    <input hidden name="image_2" value="${empty image_2 ? '2.png' : image_2}">
                </td>
                <td class="image">
                    <img src="images/${empty image_3 ? '3.png' : image_3}" alt="Image is missing">
                    <input hidden name="image_3" value="${empty image_3 ? '3.png' : image_3}">
                </td>
            </tr>
            <tr class="button_row">
                <td class="button">
                    <button class="btn" type="submit">Generate Comic</button>
                </td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>