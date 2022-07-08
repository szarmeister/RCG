package com.rcg;

import java.io.*;
import java.net.MalformedURLException;
import java.util.*;
import java.util.stream.Collectors;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "comicGenerator", value = "/generate_comics")
public class ComicGeneratorServlet extends HttpServlet {

    private List<String> directoryFilesList;

    @Override
    public void init() throws ServletException {
        super.init();
        String imagesPath;
        try {
            imagesPath = getServletContext().getResource("/comic_images").getPath();
        } catch (MalformedURLException e) {
            throw new RuntimeException(e);
        }
        directoryFilesList = Arrays.asList(Objects.requireNonNull(new File(imagesPath).list()));
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Boolean[] imageLockedState = new Boolean[3];
        imageLockedState[0] = request.getParameter("image_lock_1").equals("yes");
        imageLockedState[1] = request.getParameter("image_lock_2").equals("yes");
        imageLockedState[2] = request.getParameter("image_lock_3").equals("yes");

        String[] images = new String[3];
        images[0] = request.getParameter("image_1");
        images[1] = request.getParameter("image_2");
        images[2] = request.getParameter("image_3");

        List<String> filesList = new ArrayList<>(directoryFilesList);
        filesList = filesList.stream().filter(file -> checkImage(file, images, imageLockedState)).collect(Collectors.toList());

        List<String> randomImages = getNewImages(filesList, (int) Arrays.stream(imageLockedState)
                .filter(element -> !element).count());

        List<String> newImages = new ArrayList<>();

        for (int i = 0; i < imageLockedState.length; i++) {
            if (imageLockedState[i]) {
                newImages.add(images[i]);
            } else {
                newImages.add(randomImages.get(0));
                randomImages.remove(0);
            }
        }

        String[] lockState = new String[3];
        lockState[0] = imageLockedState[0] ? "fa-solid fa-lock" : "fa-solid fa-lock-open";
        lockState[1] = imageLockedState[1] ? "fa-solid fa-lock" : "fa-solid fa-lock-open";
        lockState[2] = imageLockedState[2] ? "fa-solid fa-lock" : "fa-solid fa-lock-open";

        request.setAttribute("image_1", newImages.get(0));
        request.setAttribute("image_2", newImages.get(1));
        request.setAttribute("image_3", newImages.get(2));

        request.setAttribute("image_1_lockStateClass", lockState[0]);
        request.setAttribute("image_2_lockStateClass", lockState[1]);
        request.setAttribute("image_3_lockStateClass", lockState[2]);

        request.setAttribute("image_1_lockState", request.getParameter("image_lock_1"));
        request.setAttribute("image_2_lockState", request.getParameter("image_lock_2"));
        request.setAttribute("image_3_lockState", request.getParameter("image_lock_3"));

        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/comic.jsp");
        requestDispatcher.forward(request, response);
    }

    private boolean checkImage(String file, String[] images, Boolean[] imageLockedState) {
        if(file.equals(images[0]) && imageLockedState[0]) {
            return false;
        } else if(file.equals(images[1]) && imageLockedState[1]) {
            return false;
        } else return !file.equals(images[2]) || !imageLockedState[2];
    }

    private List<String> getNewImages(List<String> images, int numberOfElements) {
        Random random = new Random();
        List<String> randomImages = new ArrayList<>();

        for (int i = 0; i < numberOfElements; i++) {
            int randomIndex = random.nextInt(images.size());
            randomImages.add(images.get(randomIndex));
            images.remove(randomIndex);
        }

        return randomImages;
    }


}