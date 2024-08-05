package com.xadmin.projetjsp.bean;

public class Apparte {
	
	private int id;
	private int numApp;
	private String design;
	private float loyer;
	
	
	public Apparte (int numApp, String design, float loyer) {
		super();
		this.numApp = numApp;
		this.design = design;
		this.loyer = loyer;
	}
	public Apparte(int id, int numApp, String design, float loyer) {
		super();
		this.id = id;
		this.numApp = numApp;
		this.design = design;
		this.loyer = loyer;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getNumApp() {
		return numApp;
	}
	public void setNumApp(int numApp) {
		this.numApp = numApp;
	}
	public String getDesign() {
		return design;
	}
	public void setDesign(String design) {
		this.design = design;
	}
	public float getLoyer() {
		return loyer;
	}
	public void setLoyer(float loyer) {
		this.loyer = loyer;
	}

}
