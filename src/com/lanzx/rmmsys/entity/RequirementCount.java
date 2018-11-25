package com.lanzx.rmmsys.entity;

public class RequirementCount {
	
	private String requirementType;
	
	private String rBeginCounts;
	
	private String rRuningCounts;
	
	private String rFinishCounts;
	
	private String rCloseCounts;


	public String getRequirementType() {
		return requirementType;
	}

	public void setRequirementType(String requirementType) {
		this.requirementType = requirementType;
	}

	public String getRBeginCounts() {
		return rBeginCounts;
	}

	public void setRBeginCounts(String beginCounts) {
		rBeginCounts = beginCounts;
	}

	public String getRCloseCounts() {
		return rCloseCounts;
	}

	public void setRCloseCounts(String closeCounts) {
		rCloseCounts = closeCounts;
	}

	public String getRFinishCounts() {
		return rFinishCounts;
	}

	public void setRFinishCounts(String finishCounts) {
		rFinishCounts = finishCounts;
	}

	public String getRRuningCounts() {
		return rRuningCounts;
	}

	public void setRRuningCounts(String runingCounts) {
		rRuningCounts = runingCounts;
	}

}
