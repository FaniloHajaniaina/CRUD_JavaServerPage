package com.xadmin.projetjsp.web;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xadmin.projetjsp.bean.Apparte;
import com.xadmin.projetjsp.dao.ApparteDao;

import java.sql.SQLException;
import java.util.List;


/**
 * Servlet implementation class AppServlet
 */
@WebServlet("/")
public class AppServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       private ApparteDao apparteDao;

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init() throws ServletException {
		apparteDao = new ApparteDao();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getServletPath();
		switch(action) {
		case"/new":
			showNewForm(request, response);
			break;
	    
		case"/diagramme":
			showDiagForm(request, response);
			break;
			
		case"/insert":
			insertApparte(request, response);
			break;
			
		case"/delete":
			deleteApparte(request, response);
			break;
			
		case"/edit":
			showEditForm(request, response);
			break;
			
			
		case"/update":
			try {
				updateApparte(request, response);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			break;
			
			default:
				listApparte(request, response);
				break;
		}
	}
		
		private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			RequestDispatcher dispatcher = request.getRequestDispatcher("apparte-form.jsp");
			dispatcher.forward(request, response);
		}
		
		private void showDiagForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    try {
		        // Calcul du loyer maximal, minimal et total
		        float maxLoyer = Float.MIN_VALUE;
		        float minLoyer = Float.MAX_VALUE;
		        float totalLoyer = 0;

		        List<Apparte> listApparte = apparteDao.selectAllApparte();

		        for (Apparte apparte : listApparte) {
		            if (apparte.getLoyer() > maxLoyer) {
		                maxLoyer = apparte.getLoyer();
		            }
		            if (apparte.getLoyer() < minLoyer) {
		                minLoyer = apparte.getLoyer();
		            }
		            totalLoyer += apparte.getLoyer();
		        }

		        // Transférer les valeurs au JSP
		        request.setAttribute("maxLoyer", maxLoyer);
		        request.setAttribute("minLoyer", minLoyer);
		        request.setAttribute("totalLoyer", totalLoyer);
		        
		        RequestDispatcher dispatcher = request.getRequestDispatcher("diag-form.jsp");
		        dispatcher.forward(request, response);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}

		
		//Insert Appartement
		private void insertApparte(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    String numAppStr = request.getParameter("numApp").trim();
		    String design = request.getParameter("design").trim();
		    String loyerStr = request.getParameter("loyer").trim();

		    if (!numAppStr.isEmpty() && !design.isEmpty() && !loyerStr.isEmpty()) {
		        try {
		            int numApp = Integer.parseInt(numAppStr);
		            float loyer = Float.parseFloat(loyerStr);
		            
		            Apparte newApparte = new Apparte(numApp, design, loyer);
		            
		            apparteDao.insertApparte(newApparte);
		            response.sendRedirect("List");
		        } catch (NumberFormatException e) {
		            e.printStackTrace();
		            response.getWriter().println("Erreur de type numApp || loyer");
		        } catch (SQLException e) {
		            e.printStackTrace();
		            response.getWriter().println("Une erreur ajout appartement.");
		        }
		    } else {
		        response.getWriter().println("Veuiller Remplir tous les champs!");
		    }
		}

		
		//Delete Appartement
		private void deleteApparte(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			int id = Integer.parseInt(request.getParameter("id"));
			try {
				apparteDao.deleteApparte(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			response.sendRedirect("List");
		}
		
		//Edit 
		private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			int id = Integer.parseInt(request.getParameter("id"));
			
			Apparte existingApparte;
			try {
				existingApparte = apparteDao.selectApparte(id);
				RequestDispatcher dispatcher = request.getRequestDispatcher("apparte-form.jsp");
				request.setAttribute("apparte", existingApparte);
				dispatcher.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//Update
		private void updateApparte(HttpServletRequest request, HttpServletResponse response) throws  IOException, SQLException {
			int id = Integer.parseInt(request.getParameter("id")); 
			int numApp = Integer.parseInt(request.getParameter("numApp"));
		    String design = request.getParameter("design");
		    float loyer = Float.parseFloat(request.getParameter("loyer"));
		    
		    Apparte apparte = new Apparte(id, numApp, design, loyer);
		    apparteDao.updateApparte(apparte);
		    response.sendRedirect("List");
		}
		
		
		//Default
		private void listApparte(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		    try {
		        List<Apparte> listApparte = apparteDao.selectAllApparte();

		        // Calcul du loyer maximal, minimal et total
		        float maxLoyer = Float.MIN_VALUE;
		        float minLoyer = Float.MAX_VALUE;
		        float totalLoyer = 0;

		        for (Apparte apparte : listApparte) {
		            if (apparte.getLoyer() > maxLoyer) {
		                maxLoyer = apparte.getLoyer();
		            }
		            if (apparte.getLoyer() < minLoyer) {
		                minLoyer = apparte.getLoyer();
		            }
		            totalLoyer += apparte.getLoyer();
		        }

		        // Transférer les valeurs à la vue JSP
		        request.setAttribute("maxLoyer", maxLoyer);
		        request.setAttribute("minLoyer", minLoyer);
		        request.setAttribute("totalLoyer", totalLoyer);
		        request.setAttribute("listApparte", listApparte); 
		        RequestDispatcher dispatcher = request.getRequestDispatcher("apparte-list.jsp");
		        dispatcher.forward(request, response);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}



		
		
		
		


}
