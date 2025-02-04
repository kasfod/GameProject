package controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import constants.Constants;
import dao.BoardDAO;
import dao.FilesDAO;
import dao.ReplyDAO;
import dto.BoardDTO;
import dto.FilesDTO;
// 주석

@WebServlet("*.board")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		String cmd = request.getRequestURI();
		ReplyDAO replyDAO = ReplyDAO.getInstance();

		Gson gson = new GsonBuilder().registerTypeAdapter(Timestamp.class, new JsonSerializer<Timestamp>() {
			private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd. HH:mm");

			@Override
			public JsonElement serialize(Timestamp arg0, Type arg1, JsonSerializationContext arg2) {
				return new JsonPrimitive(sdf.format(arg0));
			}
		}).create();
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		gson.toJson(timestamp);
		BoardDAO boardDAO = BoardDAO.getInstance();
		FilesDAO fileDAO = FilesDAO.getInstance();
		try {
			if(cmd.equals("/list.board")) { // 게시물 리스트 가져오기
				int currentPage = request.getParameter("cPage")==null ? 1 : Integer.parseInt(request.getParameter("cPage"));
				String keyword = request.getParameter("keyword");

				// 검색어 X, 평상시 게시물 로드
				if(keyword == null) {
					List<BoardDTO> listDTO = boardDAO.selectBy(currentPage * Constants.RECORD_COUNT_PER_PAGE - 9, currentPage* Constants.RECORD_COUNT_PER_PAGE);

					request.getSession().setAttribute("latestPage", currentPage);
					request.setAttribute("listDTO", listDTO);

					request.setAttribute("recordTotalCount", boardDAO.getRecordCount());
					request.setAttribute("recordCountPerPage", Constants.RECORD_COUNT_PER_PAGE);
					request.setAttribute("naviCountPerPage", Constants.NAVI_COUNT_PER_PAGE);
				} 
				// 검색어 O, 해당 게시물만 로드
				else {
					List<BoardDTO> listDTO = boardDAO.selectBy(currentPage * Constants.RECORD_COUNT_PER_PAGE - 9, currentPage* Constants.RECORD_COUNT_PER_PAGE, keyword);

					request.getSession().setAttribute("latestPage", currentPage);
					request.setAttribute("listDTO", listDTO);
					request.setAttribute("keyword", keyword);

					request.setAttribute("recordTotalCount", boardDAO.getRecordCountOnSearch(keyword));
					request.setAttribute("recordCountPerPage", Constants.RECORD_COUNT_PER_PAGE);
					request.setAttribute("naviCountPerPage", Constants.NAVI_COUNT_PER_PAGE);
				}

				request.getRequestDispatcher("/board/freeboard.jsp").forward(request, response);
			} else if(cmd.equals("/insert.board")) { // 게시물 등록

				String uploadPath = request.getServletContext().getRealPath("files");
				File filesPath = new File(uploadPath);
				if(!filesPath.exists()) {filesPath.mkdir();} // 폴더가 없다면 만들어라
				int maxSize = 1024 * 1024 * 10; // 업로드 파일 최대 사이즈 : 10MB	
				MultipartRequest multi = new MultipartRequest(request, uploadPath , maxSize, "utf8", new DefaultFileRenamePolicy());
				String writer = (String)request.getSession().getAttribute("loginID");
				String title = multi.getParameter("title");
				String contents = multi.getParameter("contents");
				String game_name = multi.getParameter("game_name");
				int result = boardDAO.insert(new BoardDTO(0,writer,title,contents,null,0,game_name));		

				Enumeration<String> fileNames = multi.getFileNames();
				while(fileNames.hasMoreElements()) {
					String fileName = fileNames.nextElement();
					System.out.println(fileName);
					if(multi.getFile(fileName) != null) { // multi.getFile(fileName) : 파일 크기 -> 파일이 없다면 null 반환
						String ori_name = multi.getOriginalFileName(fileName);
						String sys_name = multi.getFilesystemName(fileName);
						fileDAO.insert(new FilesDTO(0,ori_name,sys_name,result));
					}
				}

				response.sendRedirect("/list.board");

			} else if(cmd.equals("/delete.board")) { // 게시물 삭제

				int seq = Integer.parseInt(request.getParameter("seq"));
				int result = boardDAO.delContents(seq);
				response.sendRedirect("/list.board");

			} else if(cmd.equals("/update.board")) { // 게시물 수정

				String uploadPath = request.getServletContext().getRealPath("files");
				File filesPath = new File(uploadPath);
				if(!filesPath.exists()) {filesPath.mkdir();}
				int maxSize = 1024 * 1024 * 10;
				MultipartRequest multi = new MultipartRequest(request, uploadPath , maxSize, "utf8", new DefaultFileRenamePolicy());

				int seq = Integer.parseInt(multi.getParameter("seq"));
				String title = multi.getParameter("title");
				String contents = multi.getParameter("contents");
				String game_name = multi.getParameter("game_name");
				int result = boardDAO.update(new BoardDTO(seq, null, title, contents, null, 0, game_name));      

//				Enumeration<String> fileNames = multi.getFileNames();

//				while(fileNames.hasMoreElements()) {
//					String fileName = fileNames.nextElement();
//					if(multi.getFile(fileName) != null) {
//						String ori_name = multi.getOriginalFileName(fileName);
//						String sys_name = multi.getFilesystemName(fileName);
//						fileDAO.insert(new FilesDTO(0,ori_name,sys_name,result));
//					}
//				}
				
				response.sendRedirect("/showContents.board?seq="+seq);
				
			} else if(cmd.equals("/goToEdit.board")) { // 글수정 창으로 이동
				int seq = Integer.parseInt(request.getParameter("seq"));

				BoardDTO dto = boardDAO.showContents(seq);
				List<FilesDTO> fileList = fileDAO.selectFile(seq);
				request.setAttribute("contentsList", dto);
				request.setAttribute("fileList", fileList);

				request.getRequestDispatcher("/board/editBoard.jsp").forward(request, response);
			}else if(cmd.equals("/showContents.board")) { // 게시글 보기
				int currentPage = request.getParameter("cPage")==null ? 1 : Integer.parseInt(request.getParameter("cPage"));
				request.getSession().setAttribute("latestPage", currentPage);
				int currentReplyPage=1;
				if(request.getParameterMap().containsKey("currentReplyPage")) {
					currentReplyPage = Integer.parseInt(request.getParameter("currentReplyPage"));
				}
				request.getSession().setAttribute("latestReplyPageNum", currentReplyPage);
				request.setAttribute("recordCountPerPage", Constants.RECORD_COUNT_PER_PAGE);
				request.setAttribute("naviCountPerPage", Constants.NAVI_COUNT_PER_PAGE);
				request.setAttribute("currentReplyPage", currentReplyPage);

				int seq = Integer.parseInt(request.getParameter("seq"));
				request.setAttribute("recordTotalCount",replyDAO.countReply(seq));
				int view_countResult = boardDAO.viewCountUpdate(seq);
				BoardDTO dto = boardDAO.showContents(seq);

				int replyCount = replyDAO.countReply(seq);
				request.setAttribute("replyCount", replyCount);
				request.setAttribute("dto", dto);
				request.getRequestDispatcher("/board/boardContents.jsp").forward(request, response);
			} else if(cmd.equals("/search.board")) { // 게시글 검색 ( 제목 & 내용 & 카테고리 )
				String title = request.getParameter("searchTitle");
				// List<BoardDTO> list = boardDAO.searchList(title);
			} else if(cmd.equals("/indexList.board")) { // index에 최근 5개의 게시물을 올리는 코드입니다.
				List<BoardDTO> selectFive = boardDAO.selectRecentFive();
				request.setAttribute("fiveList", selectFive);
				response.setContentType("text/html; charset=utf8");
				PrintWriter pw = response.getWriter();//response의 내용을 담는다.
				pw.append(gson.toJson(selectFive));
			}
		} catch(Exception e) {
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}