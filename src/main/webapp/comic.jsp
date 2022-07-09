<%--@elvariable id="image_lockState" type="java.util.List<String>"--%>
<%--@elvariable id="image" type="java.util.List<String>"--%>

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

        window.onload = function checkInitialLockState() {
            const elements = document.getElementsByTagName('i');
            for (let i = 0; i < elements.length; i++) {
                if (elements[i].id.includes('image_lock_')) {
                    if (elements[i].className === 'fa-solid fa-lock-open') {
                        elements[i].style.color = '#c5b1ae';
                    } else {
                        elements[i].style.color = '#ff871b';
                    }
                }
            }
        }

        function lockImage(lockId, className, containerId) {
            const element = document.getElementById(lockId);
            if (className === 'fa-solid fa-lock-open') {
                element.className = 'fa-solid fa-lock';
                element.style.color = '#ff871b';
            } else {
                element.className = 'fa-solid fa-lock-open';
                element.style.color = '#c5b1ae';
            }

            const elements = document.getElementById(containerId).getElementsByTagName('input');
            for (let i = 0; i < elements.length; i++) {
                elements[i].value === 'no' ? elements[i].value = 'yes' : elements[i].value = 'no';
                console.log(elements[i].value);
            }
        }

    </script>
</head>
<body>

<div class="title">Random Comic Generator</div>
<div class="main">
    <form class="comic_generator" action="generate_comics" method="get">
        <table class="comic_generator">
            <tr class="lock_icon_row">
                <td id="lock_icon_1" class="lock_icon">
                    <i id="image_lock_1" class="${image_lockState.get(0) ? 'fa-solid fa-lock' : 'fa-solid fa-lock-open'}" onclick="lockImage(this.id, this.className, 'lock_icon_1')"></i>
                    <input hidden name="image_lock" value="${image_lockState.get(0) ? 'yes' : 'no'}">
                </td>
                <td id="lock_icon_2" class="lock_icon">
                    <i id="image_lock_2" class="${image_lockState.get(1) ? 'fa-solid fa-lock' : 'fa-solid fa-lock-open'}" onclick="lockImage(this.id, this.className, 'lock_icon_2')"></i>
                    <input hidden name="image_lock" value="${image_lockState.get(1) ? 'yes' : 'no'}">
                </td>
                <td id="lock_icon_3" class="lock_icon">
                    <i id="image_lock_3" class="${image_lockState.get(2) ? 'fa-solid fa-lock' : 'fa-solid fa-lock-open'}" onclick="lockImage(this.id, this.className, 'lock_icon_3')"></i>
                    <input hidden name="image_lock" value="${image_lockState.get(2) ? 'yes' : 'no'}">
                </td>
            </tr>
            <tr class="image_row">
                <td class="image">
                    <img src="comic_images/${empty image.get(0) ? '1.png' : image.get(0)}" alt="Image is missing">
                    <input hidden name="image" value="${empty image.get(0) ? '1.png' : image.get(0)}">
                </td>
                <td class="image">
                    <img src="comic_images/${empty image.get(1) ? '2.png' : image.get(1)}" alt="Image is missing">
                    <input hidden name="image" value="${empty image.get(1) ? '2.png' : image.get(1)}">
                </td>
                <td class="image">
                    <img src="comic_images/${empty image.get(2) ? '3.png' : image.get(2)}" alt="Image is missing">
                    <input hidden name="image" value="${empty image.get(2) ? '3.png' : image.get(2)}">
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