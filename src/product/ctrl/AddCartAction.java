package product.ctrl;

import java.util.*;

import javax.mail.Session;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.ctrl.AbstractController;
import member.mdl.MemberVO;
import myshop.mdl.*;
import Payment.mdl.*;

public class AddCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		InterProductDAO pdao = new ProductDAO();
		HttpSession session = request.getSession();
		
		String pcolor = request.getParameter("pcolor");
		String size = request.getParameter("size");
		String pdno = request.getParameter("pdno");
		
		// 로그인된 유저의 아이디 정보를 받아온다.
		String userid = ((MemberVO)session.getAttribute("loginuser")).getUserid(); 
		
		System.out.println("AddCartAct- pcolor ==> " + pcolor);
		System.out.println("AddCartAct- size ==> " + size);
		System.out.println("AddCartAct- pdno ==> " + pdno);
		
		
		// 주문수량은 별도로 카트에 담아줄것
		String pqty = request.getParameter("pqty");
		System.out.println("AddCartAct- pqty ==>" + pqty);
		
		String pinfono = pdao.getPinfono(pcolor, size, pdno);
		System.out.println("AddCartAct- pinfono ==>" + pinfono);
		
		Map<String,String> cartMap = new HashMap<>();
		
		cartMap.put("userid_fk", userid);
		cartMap.put("pinfono", pinfono);
		cartMap.put("pqty", pqty);
		
		System.out.println("AddCartAct Map Check : " + cartMap);
		
		pdao.sendCartList(cartMap);
		
		/*
		 * int CartList = pdao.sendCartList(cartMap);
		 * 
		 * String message = ""; // alert 내용 String loc = ""; // 경로
		 * 
		 * if(CartList == 1) { message = "장바구니 등록 완료"; // message 띄운후 어느 페이지로 갈래? loc =
		 * request.getContextPath() + "/product/productCart.neige"; // 성공하면 장바구니 페이지로 가자
		 * }else { message = "장바구니 등록 실패"; loc = "javascript:history.back()"; }
		 * 
		 * request.setAttribute("message", message); request.setAttribute("loc", loc);
		 * 
		 * setRedirect(false); super.setViewPage("/WEB-INF/msg.jsp");
		 */
	}

}
