package product.ctrl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import common.ctrl.AbstractController;
import myshop.mdl.InterProductDAO;
import myshop.mdl.ProductDAO;

public class CommentDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String review_seq = request.getParameter("review_seq");	// 리뷰 일련번호
		
		InterProductDAO pdao = new ProductDAO();
		
		pdao.deleteComment(review_seq);
		
	}

}
