package com.shop.developer.helpers;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.shop.developer.resources.ErrorResource;



@ControllerAdvice //xử lý ngoại lệ toàn cục trong spring boot
public class GlobalExceptionHandle {
    @ExceptionHandler(MethodArgumentNotValidException.class) //xử lý ngoại lệ khi tham số không hợp lệ
    public ResponseEntity<Object> handleValidException(MethodArgumentNotValidException exception) { // phương thức này xử lý ngoại lệ MethodArgumentNotValidException
        //MethodArgumentNotValidException dùng để xử lý các lỗi xác thực đối với các tham số của phương thức spring MVC
        
        Map<String, String> errors = new HashMap<>(); //tạo một bản đồ để lưu trữ các lỗi xác thực(authentication)
        exception.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();//lấy tên trường field bị lỗi
            String errorMessage = error.getDefaultMessage(); // lấy thông báo lỗi mặc định
            errors.put(fieldName, errorMessage); //thêm tên trường và thông báo lỗi vào bản đồ errors 
        });

        ErrorResource errorResource = new ErrorResource("Có vấn đề trong quá trình kiểm tra dữ liệu", errors);
        //tạo một đối tượng ErrorResource để chứa thông báo lỗi và bản đồ lỗi trong spring boot
        //ErrorResource là một lớp tuỳ chỉnh để định dạng phản hồi lỗi
        // "Có vấn để trong quá trình kiểm tra dữ liệu" là một thông báo lỗi chung
        

        // return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST); // trả về mã lỗi 400, 400(là mã trạng thái http không tồn tại)
        return new ResponseEntity<>(errors, HttpStatus.UNPROCESSABLE_ENTITY); // trả về mã 402 là mã trạng thái http không thể xử lý được yêu cầu
    }

    
    
}
