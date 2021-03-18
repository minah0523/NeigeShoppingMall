package product.ctrl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.ctrl.AbstractController;
import my.util.MyUtil;
import myshop.mdl.*;

public class CommentRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		String pdno = request.getParameter("pdno");
		String contents = request.getParameter("contents");
		
		// **** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드/secure code) 작성하기 **** //
		contents = MyUtil.secureCode(contents);
		
		contents = contents.replaceAll("\r\n", "<br>");
		
		PurchaseReviewsVO reviewsvo = new PurchaseReviewsVO();
		reviewsvo.setFk_userid(userid);
		reviewsvo.setFk_pdno(Integer.parseInt(pdno) );
		reviewsvo.setContents(contents);
		
		InterProductDAO pdao = new ProductDAO();
		
		int n = pdao.addComment(reviewsvo);
		
		JSONObject jsonObj = new JSONObject(); // {}
		jsonObj.put("n", n);  // {"n":1} 또는 {"n":0} 또는  {"n":2}으로 만들어준다.
		
		String json = jsonObj.toString(); // 문자열 형태인 {"n":1} 또는 {"n":0} 으로 만들어준다. 
		System.out.println(">>> 확인용 json => " + json);
	//  {"n":1}	{"n":0}  {"n":2}
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
