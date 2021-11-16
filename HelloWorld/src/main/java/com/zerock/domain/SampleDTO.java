package com.zerock.domain;

import lombok.Data;

// getter / setter를 안만들어도 자동으로 만들어줌.
@Data
public class SampleDTO {
	private String name;
	private int age;
}
