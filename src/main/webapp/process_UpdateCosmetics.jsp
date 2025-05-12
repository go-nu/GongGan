<%@ page import="java.io.*" %> <!-- 입출력 관련 클래스 -->
<%@ page import="com.oreilly.servlet.MultipartRequest" %> <!-- 파일 업로드 처리 클래스 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 파일 이름 중복 처리 정책 클래스 -->
<%@ page import="dao.CosmeticsRepository" %> <!-- 화장품 데이터 접근 객체 -->
<%@ page import="dto.Cosmetics" %> <!-- 화장품 데이터 전송 객체 -->

<%
    String savePath = application.getRealPath("/resources/img");
    int maxSize = 5 * 1024 * 1024;
    String encoding = "UTF-8";

    MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

    int id = Integer.parseInt(multi.getParameter("id"));
    String name = multi.getParameter("name");
    String brand = multi.getParameter("brand");
    int price = Integer.parseInt(multi.getParameter("price"));
    String main_ingredient = multi.getParameter("main_ingredient");
    String effect = multi.getParameter("effect");
    String category = multi.getParameter("category");
    String image_file = multi.getFilesystemName("image_file");

    CosmeticsRepository repo = CosmeticsRepository.getInstance();
    Cosmetics cosmetic = repo.getCosmeticsById(id);

    cosmetic.setName(name);
    cosmetic.setBrand(brand);
    cosmetic.setPrice(price);
    cosmetic.setMain_ingredient(main_ingredient);
    cosmetic.setEffect(effect);
    cosmetic.setCategory(category);
    if (image_file != null) {
        cosmetic.setImage_file(image_file);
    }

    repo.updateCosmetic(cosmetic);

    response.sendRedirect("beautyList.jsp");
%>
