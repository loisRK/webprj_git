package com.iot.pf.exception;

public class AnomalyException extends Exception {
	
	public AnomalyException() {
		super("You have an anmoaly result value after [INSERT/UPDATE/DELETE] query!!!");
	}
	
	public AnomalyException(String msg) {
		super(msg);
	}
	
	public AnomalyException(int expected, int result) {
		super("You have an anmoaly result value after [INSERT/UPDATE/DELETE] query!!!"
				+ "\n expected result " + expected + ", but result was " + result);
	}
}
