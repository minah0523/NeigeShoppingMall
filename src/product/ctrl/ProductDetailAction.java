package product.ctrl;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.ctrl.AbstractController;
import Payment.mdl.*;
import myshop.mdl.*;
import myshop.mdl.ProductVO;

public class ProductDetailAction extends AbstractController {
	
	@Override
	public String toString() {
		return "@@@ : 클래스 IndexController의 인스턴스 메소드 toString() 호출";
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// System.out.println("@@@ 확인용 IndexController의 메소드 execute호출됨");
				
		InterProductDAO pdao = new ProductDAO();
		String pdno = "";
		
		// pdno를 사용하여 해당 상품의 정보가 담긴 ProductVO를 받는다.
		pdno = request.getParameter("pdno");
		ProductVO pdvo = pdao.selectOneProductByPdno(pdno);
		
		
		
		if (pdvo == null) {
			// GET 방식이므로 사용자가 웹브라우저 주소창에서 장난쳐서 존재하지 않는 제품번호를 입력한 경우
			String message = "검색하신 제품은 존재하지 않습니다.";
			String loc = "javascript:history.back()";

			request.setAttribute("message", message);
			request.setAttribute("loc", loc);

			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
			
		} else {
			// 제품이 있는 경우
			request.setAttribute("pdvo", pdvo); // 제품의 정보를 저장한다.
			
			// 옵션선택에서 productinfoList로 for문을 돌릴경우 color*size의 갯수만큼 반복해야하기때문에 
			// 컬러와 사이즈를 따로 보내주어 중복없이 컬러와 사이즈를 보여주도록 한다 (MINA)
			
			// String 으로 구성된 상품 컬러 리스트를 만들어 view 단으로 보낸다
			List<String> productColorList = pdao.selectProductColor(pdno);
			request.setAttribute("productColorList", productColorList);
			
			// String 으로 구성된 상품 사이즈 리스트를 만들어 view 단으로 보낸다
			List<String> productSizeList = pdao.selectProductSize(pdno);
			request.setAttribute("productSizeList", productSizeList);
			
			
			// 로그인을 하지 않은 상태에서 특정제품을 조회한 후 장바구니 담기나 바로 주문하기 할 때와 제품후기 쓰기를 할 때 로그인 하라는 메시지를
			// 받은 후 로그인 하면 메인페이지로 가는 것이 아니라 방금 조회한 특정제품 페이지로 돌아가기 위한 것임.
			// 로그인을 하면 시작페이지로 가는 것이 아니라 방금 봤던 페이지를 그대로 유지하는 것이다.
			super.goBackURL(request);

			//super.setRedirect(false);
			super.setViewPage("/WEB-INF/productdetail/ProductDetail.jsp");
			
		}			
			
	}												
		
}


