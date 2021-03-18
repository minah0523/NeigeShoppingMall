package product.ctrl;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.ctrl.AbstractController;
import myshop.mdl.*;

public class LikeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO pdao = new ProductDAO();
		
		// 상품번호를 받아온다
		String pdno = "";
		pdno = request.getParameter("pdno");
		
		// 사용자 id를 받아온다
		String userid = "";
		userid = request.getParameter("userid");
		
		// alert을 띄울 메세지
		String msg = "";

		// 로그인 유저 유무 확인
		if(userid=="" || userid==null) {
			msg="로그인 후에 좋아요를 클릭할 수 있습니다.";
		}

		// 로그인 유저가 존재한다면
		else {
			
			Map<String,String> paraMap = new HashMap<>();
			paraMap.put("pdno", pdno);
			paraMap.put("userid", userid);
			
			int n = pdao.like(paraMap);
			
			// n = 1 이라면 정상투표,  n = 0 이라면 중복투표
			if(n==1) {
				msg = "해당제품에\n 좋아요를 클릭하셨습니다.";
			}
			else {
				msg = "이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다.";
			}
			
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("msg", msg); // {"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}   {"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."} 
		System.out.println("likeact jsonObj : " + jsonObj);
		
		String json = jsonObj.toString(); // "{"msg":"해당제품에\n 좋아요를 클릭하셨습니다."}"   "{{"msg":"이미 좋아요를 클릭하셨기에\n 두번 이상 좋아요는 불가합니다."}}" 
		System.out.println("likeact json : " + json);
		
		request.setAttribute("json", json);
		
		//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
