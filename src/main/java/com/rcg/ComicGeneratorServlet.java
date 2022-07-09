package com.rcg;

import java.io.*;
import java.net.MalformedURLException;
import java.util.*;
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
        List<Boolean> imagesLockedState = new ArrayList<>(convertStringToBoolean(request.getParameterValues("image_lock")));
        List<String> images = new ArrayList<>(Arrays.asList(request.getParameterValues("image")));

        List<String> lockedImages = new ArrayList<>();

        for (int i = 0; i < images.size(); i++) {
            if (imagesLockedState.get(i)) {
                lockedImages.add(images.get(i));
            }
        }

        List<String> randomImages = getRandomImages(lockedImages, images.size() - lockedImages.size());
        List<String> newImages = new ArrayList<>();

        for (int i = 0; i < images.size(); i++) {
            if (imagesLockedState.get(i)) {
                newImages.add(images.get(i));
            } else {
                newImages.add(randomImages.get(0));
                randomImages.remove(0);
            }
        }

        request.setAttribute("image", newImages);
        request.setAttribute("image_lockState", imagesLockedState);

        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/comic.jsp");
        requestDispatcher.forward(request, response);
    }

    private List<Boolean> convertStringToBoolean(String[] stringArray) {
        List<Boolean> booleanList = new ArrayList<>();

        for (String string : stringArray) {
            if (string.equals("yes")) {
                booleanList.add(true);
            } else {
                booleanList.add(false);
            }
        }

        return booleanList;
    }

    private List<String> getRandomImages(List<String> lockedImages, int numberOfElements) {
        Random random = new Random();
        List<String> randomImages = new ArrayList<>();

        while (randomImages.size() < numberOfElements) {
            int randomIndex = random.nextInt(directoryFilesList.size());
            String image = directoryFilesList.get(randomIndex);
            if (!lockedImages.contains(image) && !randomImages.contains(image)) {
                randomImages.add(image);
            }
        }

        return randomImages;
    }


}