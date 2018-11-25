package com.lanzx.rmmsys.encoder;

public class ShaPasswordEncoderImpl extends AbstractPasswordEncoderImpl {

	public ShaPasswordEncoderImpl(){
		setMethod("SHA");
	}
}
