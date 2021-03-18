package product.ctrl;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.ctrl.AbstractController;
import myshop.mdl.*;

public class LikeCntAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pdno = "";
		pdno = request.getParameter("pdno");
		
		InterProductDAO pdao = new ProductDAO();
		
		System.out.println("Likecntact pdno1 : " + pdno);
		Map<String, Integer> map = pdao.getLikeCnt(pdno);
		System.out.println("Likecntact map: " + map);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("likecnt", map.get("likecnt"));			// {"likecnt":1}
		System.out.println("Likecntact jsonObj : " + jsonObj);
		
		String json = jsonObj.toString();	// {"likecnt":1,"dislikecnt":0}
		
		request.setAttribute("json", json);
		System.out.println("Likecntact json : " + json);
		System.out.println("Likecntact pdno3 : " + pdno);
		
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
		
		
	}

}
 
