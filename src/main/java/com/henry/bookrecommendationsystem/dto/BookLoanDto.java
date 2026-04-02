package com.henry.bookrecommendationsystem.dto;

import com.henry.bookrecommendationsystem.dto.base.BaseDto;
import com.henry.bookrecommendationsystem.enums.BookLoanStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * @author Codex
 * @since 02/04/2026
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class BookLoanDto extends BaseDto {
    private Long id;
    private UserDto user;
    private BookDto book;
    private LocalDateTime borrowedAt;
    private LocalDateTime dueDate;
    private LocalDateTime returnedAt;
    private Integer renewCount;
    private BookLoanStatus status;
}
