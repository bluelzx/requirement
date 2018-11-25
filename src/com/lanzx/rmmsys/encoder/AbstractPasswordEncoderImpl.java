package com.lanzx.rmmsys.encoder;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public abstract class AbstractPasswordEncoderImpl implements PasswordEncoder {

	private String salt = "1q2w3e4r";

	private String method = "";

	public String encode(String password) {

		String pwd = null;

		MessageDigest md;
		try {
			md = MessageDigest.getInstance(method);
			md.update((salt + password).getBytes());
			byte[] tmp = md.digest();
			pwd = hex2String(tmp);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}

		return pwd;
	}

	private String hex2String(byte[] tmp) {
		char str[] = new char[16 * 2];
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };
		for (int i = 0, k = 0; i < 16; i++) {
			str[k++] = hexDigits[tmp[i] >>> 4 & 0xf];
			str[k++] = hexDigits[tmp[i] & 0xf];
		}
		return new String(str);
	}

	public String getSalt() {
		return salt;
	}

	public void setSalt(String salt) {
		this.salt = salt;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

}
