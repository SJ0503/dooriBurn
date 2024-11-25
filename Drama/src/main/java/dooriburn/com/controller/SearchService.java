package dooriburn.com.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;

@WebServlet("/SearchService")
public class SearchService extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String s_option = request.getParameter("s_option");
        String search = request.getParameter("search");
        int pageNum = Integer.parseInt(request.getParameter("pageNum"));
        int pageSize = 10; // 한 페이지에 출력될 글 수

        if (request.getParameter("pageNum") != null) {
            pageNum = Integer.parseInt(request.getParameter("pageNum"));
        }

        int startRow = (pageNum - 1) * pageSize;  // 0 기반 인덱스
        int cnt = 0;

        ArrayList<String> titles = new ArrayList<>();
        ArrayList<String> img_src = new ArrayList<>();
        ArrayList<String> places = new ArrayList<>();
        ArrayList<String> scene = new ArrayList<>();
        ArrayList<Integer> index = new ArrayList<>();

        HttpURLConnection conn = null;

        try {
            URL url = new URL("http://localhost:5002/search?s_option=" + s_option + "&search=" + URLEncoder.encode(search, "UTF-8"));
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Accept", "application/json");

            int responseCode = conn.getResponseCode();
            System.out.println("GET Response Code :: " + responseCode);

            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
                String inputLine;
                StringBuilder response_data = new StringBuilder();

                while ((inputLine = in.readLine()) != null) {
                    response_data.append(inputLine);
                }
                in.close();
                JSONArray jsonArray = new JSONArray(response_data.toString());
                cnt = jsonArray.length();
                if (jsonArray.length() > 0) {
                    for (int i = startRow; i < startRow + pageSize && i < cnt; i++) {
                        JSONObject jsonObject = jsonArray.getJSONObject(i);
                        titles.add(jsonObject.optString("제목", ""));
                        places.add(jsonObject.optString("장소명", ""));
                        img_src.add(jsonObject.optString("img", ""));
                        scene.add(jsonObject.optString("장소설명", ""));
                        index.add(jsonObject.optInt("index", -1));
                    }
                    request.setAttribute("index", index);
                } else {
                    request.setAttribute("message", "No results found.");
                }
            } else {
                request.setAttribute("message", "GET request not worked");
            }
        } catch (JSONException e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("index", null);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("index", null);
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }

        request.setAttribute("titles", titles);
        request.setAttribute("places", places);
        request.setAttribute("img_src", img_src);
        request.setAttribute("scene", scene);
        
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("cnt", cnt);
        request.setAttribute("search", search);
        request.setAttribute("s_option", s_option);

        request.getRequestDispatcher("PracSearch2.jsp").forward(request, response);

        for (int i = 0; i < titles.size(); i++) {
            System.out.println(titles.get(i));
        }
    }
}
