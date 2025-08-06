create database amazondb;
use amazondb;
select * from amazon_data;

SELECT product_name, discounted_price
FROM amazon_data
WHERE discount_percentage IS NOT NULL
ORDER BY Main_Category, discounted_price DESC;


SELECT product_name, Main_Category, Sub_Category_1
FROM amazon_data
WHERE Sub_Category_1 = 'Televisions';

DELIMITER $$

CREATE PROCEDURE GetTopRatedBySubCategory(
    IN input_department VARCHAR(100),
    IN input_subcategory VARCHAR(100),
    IN limit_count INT
)
BEGIN
    SELECT product_name, rating, rating_count, discounted_price
    FROM amazon_data
    WHERE Department = input_department
      AND Sub_Category_1 = input_subcategory
      AND rating IS NOT NULL
    ORDER BY rating DESC, rating_count DESC
    LIMIT limit_count;
END $$

DELIMITER ;

call GetTopRatedBySubCategory('Kitchen&HomeAppliances', 'WaterPurifiers&Accessories', 10);

DELIMITER $$

CREATE PROCEDURE FilterProductsByCategoryAndPrice(
    IN category_name VARCHAR(100),
    IN min_price DECIMAL(10,2),
    IN max_price DECIMAL(10,2)
)
BEGIN
    SELECT product_name, discounted_price, actual_price, Main_Category
    FROM amazon_data
    WHERE Main_Category = category_name
      AND discounted_price BETWEEN min_price AND max_price;
END $$

DELIMITER ;

CALL FilterProductsByCategoryAndPrice('Computers&Accessories', 199, 2000);

