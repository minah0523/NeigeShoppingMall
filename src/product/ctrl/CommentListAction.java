package product.ctrl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

import common.ctrl.AbstractController;
import myshop.mdl.*;

public class CommentListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_pdno = request.getParameter("pdno");	// 제품번호
		
		InterProductDAO pdao = new ProductDAO();
		
		JSONArray jsArr = new JSONArray(); // []
		
		List<PurchaseReviewsVO> commentList = pdao.commentList(fk_pdno);
		
		if(commentList != null && commentList.size() > 0) {
		
			for(PurchaseReviewsVO reviewsvo : commentList) {
				JSONObject jsobj = new JSONObject();				// {} {}
				jsobj.put("contents", reviewsvo.getContents());		// {"contents":"제품후기내용물"}												{"contents":"제품후기내용물2"}
				jsobj.put("name", reviewsvo.getMvo().getName());	// {"contents":"제품후기내용물", "name":"작성자이름"}							{"contents":"제품후기내용물2", "name":"작성자이름2"}
				jsobj.put("writeDate", reviewsvo.getWriteDate());	// {"contents":"제품후기내용물", "name":"작성자이름", "writeDate":"작성일자"}	{"contents":"제품후기내용물2", "name":"작성자이름2", "writeDate":"작성일자2"}
				//jsobj.put("starpoint", reviewsvo.getWriteDate());	// {"contents":"제품후기내용물", "name":"작성자이름", "writeDate":"작성일자"}	{"contents":"제품후기내용물2", "name":"작성자이름2", "writeDate":"작성일자2"}
				
				jsobj.put("fk_userid", reviewsvo.getFk_userid());	// 추후 삭제를 위해 아이디도 같이 보내준다.
				jsobj.put("review_seq", reviewsvo.getReview_seq());	// 추후 삭제를 위해 일련번호도 같이 보내준다.

				jsArr.put(jsobj);	// [ {"contents":"제품후기내용물", "name":"작성자이름", "writeDate":"작성일자"}	{"contents":"제품후기내용물2", "name":"작성자이름2", "writeDate":"작성일자2"} ]
			}
			
		}
		System.out.println(jsArr.toString());
		
		String json = jsArr.toString();	// 문자열 형태로 변환해줌.
		
		request.setAttribute("json", json);
		
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
		// [{},{},{}]
		

	}

}
