package com.lanzx.rmmsys.encoder;


public class PlaintextPasswordEncoderImpl implements PasswordEncoder {

	public String encode(String password) {
		// do nothing, return the plain text passed only.
		return password;
	}

}
