package com.shop.developer.modules.gallery.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name="gallery")
public class Gallery {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
    private String image_url;
    private Integer product_id ;
    private Boolean status;

    public Gallery() {
        super();
    }
    public Gallery(Long id, String image_url, Integer product_id, Boolean status) {
        super();
        this.id = id;
        this.image_url = image_url;
        this.product_id = product_id;
        this.status = status;
    }
}
