-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 20, 2026 lúc 08:29 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `shop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `banner`
--

CREATE TABLE `banner` (
  `id` bigint(20) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `banner`
--

INSERT INTO `banner` (`id`, `image`, `status`, `title`) VALUES
(1, 'banner.png', b'1', 'banner'),
(2, 'banner1.png', b'1', 'banner'),
(3, 'banner2.png', b'1', 'banner');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `blog`
--

CREATE TABLE `blog` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `blog`
--

INSERT INTO `blog` (`id`, `title`, `description`, `image_url`) VALUES
(1, '1. Các mẫu content Facebook phổ biến nhất hiện nay', '1.1 Content tăng tương tác Trên bất kỳ nền tảng social media nào thì việc tạo content tương tác là vô cùng quan trọng. Content tăng tương tác giúp doanh nghiệp có nhiều tương tác, tăng lượt hiển thị và khả năng tiếp cận khách hàng mục tiêu. Từ đó giúp tăng khả năng tiếp thị bán hàng, thúc đẩy doanh số bán hàng hiệu quả.Thông thường, content tăng tương tác thường là content dạng bắt trend, giật tít hoặc các thông điệp gây tranh cãi trên mạng xã hội.', 'images/1759947540660_samsung_galaxy_z_fold7_xam_1_de1fb8f431.webp'),
(3, '1.2 Content định hướng khách hàng', '1.1 Content tăng tương tác Trên bất kỳ nền tảng social media nào thì việc tạo content tương tác là vô cùng quan trọng. Content tăng tương tác giúp doanh nghiệp có nhiều tương tác, tăng lượt hiển thị và khả năng tiếp cận khách hàng mục tiêu. Từ đó giúp tăng khả năng tiếp thị bán hàng, thúc đẩy doanh số bán hàng hiệu quả.Thông thường, content tăng tương tác thường là content dạng bắt trend, giật tít hoặc các thông điệp gây tranh cãi trên mạng xã hội.', 'images/1759947540660_samsung_galaxy_z_fold7_xam_1_de1fb8f431.webp'),
(4, '1.2 Content định hướng khách hàng', '1.1 Content tăng tương tác Trên bất kỳ nền tảng social media nào thì việc tạo content tương tác là vô cùng quan trọng. Content tăng tương tác giúp doanh nghiệp có nhiều tương tác, tăng lượt hiển thị và khả năng tiếp cận khách hàng mục tiêu. Từ đó giúp tăng khả năng tiếp thị bán hàng, thúc đẩy doanh số bán hàng hiệu quả.Thông thường, content tăng tương tác thường là content dạng bắt trend, giật tít hoặc các thông điệp gây tranh cãi trên mạng xã hội.', 'images/1759947540660_samsung_galaxy_z_fold7_xam_1_de1fb8f431.webp'),
(5, '1.2 Content định hướng khách hàng', '1.1 Content tăng tương tác Trên bất kỳ nền tảng social media nào thì việc tạo content tương tác là vô cùng quan trọng. Content tăng tương tác giúp doanh nghiệp có nhiều tương tác, tăng lượt hiển thị và khả năng tiếp cận khách hàng mục tiêu. Từ đó giúp tăng khả năng tiếp thị bán hàng, thúc đẩy doanh số bán hàng hiệu quả.Thông thường, content tăng tương tác thường là content dạng bắt trend, giật tít hoặc các thông điệp gây tranh cãi trên mạng xã hội.', 'images/1759947540660_samsung_galaxy_z_fold7_xam_1_de1fb8f431.webp'),
(6, '1.2 Content định hướng khách hàng', '1.1 Content tăng tương tác Trên bất kỳ nền tảng social media nào thì việc tạo content tương tác là vô cùng quan trọng. Content tăng tương tác giúp doanh nghiệp có nhiều tương tác, tăng lượt hiển thị và khả năng tiếp cận khách hàng mục tiêu. Từ đó giúp tăng khả năng tiếp thị bán hàng, thúc đẩy doanh số bán hàng hiệu quả.Thông thường, content tăng tương tác thường là content dạng bắt trend, giật tít hoặc các thông điệp gây tranh cãi trên mạng xã hội.', 'images/1759947540660_samsung_galaxy_z_fold7_xam_1_de1fb8f431.webp'),
(7, '1.2 Content định hướng khách hàng', '1.1 Content tăng tương tác Trên bất kỳ nền tảng social media nào thì việc tạo content tương tác là vô cùng quan trọng. Content tăng tương tác giúp doanh nghiệp có nhiều tương tác, tăng lượt hiển thị và khả năng tiếp cận khách hàng mục tiêu. Từ đó giúp tăng khả năng tiếp thị bán hàng, thúc đẩy doanh số bán hàng hiệu quả.Thông thường, content tăng tương tác thường là content dạng bắt trend, giật tít hoặc các thông điệp gây tranh cãi trên mạng xã hội.', 'images/1759947540660_samsung_galaxy_z_fold7_xam_1_de1fb8f431.webp');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `blog_detail`
--

CREATE TABLE `blog_detail` (
  `id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `thumbnail`, `status`) VALUES
(1, 'Điện Thoại', 'dien_thoai_icon_cate_05347c5136.webp', 1),
(2, 'Máy Tính Bảng', 'may_tinh_bang_ic_cate_dccb57ff5c.webp', 1),
(3, 'Laptop', 'laptop_ic_cate_47e7264bc7.webp', 1),
(4, 'Màn Hình', 'man_hinh_ic_cate_7663908793.webp', 1),
(5, 'Phụ Kiện', 'phu_kien_ic_cate_ecae8ddd38.webp', 1),
(32, 'Sim FPT', '1773990882471_Sim_FPT.jpg', 1),
(33, 'Đồng Hồ Thông Minh', '1773990915043_download__34_.jpg', 1),
(34, 'Tivi', '1773990938411_download__35_.jpg', 1),
(35, 'Tủ Lạnh', '1773990960174_download.png', 1),
(36, 'Robot hút bụi', '1773990984029_download__36_.jpg', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `gallery`
--

CREATE TABLE `gallery` (
  `id` bigint(20) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `gallery`
--

INSERT INTO `gallery` (`id`, `image_url`, `product_id`, `status`) VALUES
(1, 'vn-11134207-7ras8-m1pdq91ripg325.webp', 2, b'1'),
(2, 'vn-11134207-7ras8-m1pdq91rfwlbc4.webp', 2, b'1'),
(3, 'vn-11134207-7ras8-m3ahsqeyb9y9d5.webp', 2, b'1'),
(4, 'vn-11134207-7ras8-m1pdq91r8vgzc0.webp', 2, b'1'),
(5, 'vn-11134207-7ras8-m1pdq92v8nkja3.webp', 2, b'1'),
(6, 'vn-11134207-7ras8-m1pdq91rd36bf4.webp', 2, b'1'),
(7, 'vn-11134207-7r98o-lybna3p25oi53b.webp', 2, b'1');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `code`, `created_at`, `status`, `updated_at`, `user_id`) VALUES
(1, 'Q0ATXBY7', '2026-03-20 07:16:48.000000', b'1', NULL, 24),
(2, '846CP2OU', '2026-03-20 07:17:00.000000', b'1', NULL, 24),
(3, 'FUJ2IK1N', '2026-03-20 07:28:03.000000', b'1', NULL, 24),
(4, '8TRCPHNS', '2026-03-20 07:28:19.000000', b'1', NULL, 24);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `price`, `product_id`, `quantity`) VALUES
(1, 1, 2490.000, 33, 1),
(2, 2, 2490.000, 33, 1),
(3, 3, 2490.000, 33, 1),
(4, 4, 2490.000, 33, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` double DEFAULT NULL,
  `price_old` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `view` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `image`, `description`, `price`, `price_old`, `quantity`, `view`, `category_id`, `created_at`, `status`) VALUES
(33, 'Nubia A76 4GB 128GB (NFC)', '1773989803865_shopping.webp', 'Nubia A76 NFC được định vị là sản phẩm hướng đến nhóm người dùng phổ thông, đặc biệt là những ai tìm kiếm một chiếc điện thoại kết hợp hoàn hảo giữa thiết kế phong cách flagship, camera AI 50MP chuyên nghiệp và trải nghiệm Android 15 với Google Gemini tích hợp.\r\n\r\nZTE Nubia A76 NFC không chỉ đáp ứng các nhu cầu cơ bản như liên lạc, giải trí mà còn mang đến trải nghiệm vượt trội với camera chính 50MP, vi xử lý Unisoc T7250 tám nhân 1.8GHz và loạt tính năng cao cấp hiếm thấy trong phân khúc. ZTE nubia đặt mục tiêu \"không chỉ đủ dùng mà còn vượt mong đợi\" thông qua Nubia A76, định nghĩa lại trải nghiệm công nghệ phổ thông với cấu hình mạnh, thiết kế thời thượng và dung lượng cao trong mức giá hợp lý. Đây là lựa chọn lý tưởng cho giới trẻ năng động, người dùng sáng tạo nội dung hoặc bất kỳ ai muốn sở hữu một thiết bị công nghệ đáng giá.\r\n\r\nThiết kế mỏng nhẹ và hiện đại\r\nNubia A76 NFC sở hữu thiết kế mỏng nhẹ chỉ 8.5mm độ dày và trọng lượng 197g, mang lại cảm giác thoải mái khi cầm nắm và sử dụng trong thời gian dài. Kích thước tổng thể 167.3 x 77.3 x 8.3mm được tối ưu hóa để phù hợp với bàn tay người Việt, đặc biệt thuận tiện cho việc thao tác một tay và mang theo hàng ngày.', 2490, 2590, 100, 102, 1, '2025-10-08 18:14:30', 1),
(34, 'Samsung Galaxy Z Fold7 5G 12GB 256GB', '1773989828426_download__19_.jpg', 'Samsung Galaxy Z Fold 7 mở ra một kỷ nguyên mới cho điện thoại gập khi kết hợp hoàn hảo giữa kiểu dáng mỏng nhẹ, phần cứng mạnh mẽ và trí tuệ nhân tạo thông minh. Với diện mạo đẳng cấp cùng màn hình gập 8 inch siêu lớn, đây là thiết bị dành cho người dùng yêu cầu sự khác biệt và đột phá về trải nghiệm.', 43990, 56890, 100, 106, 1, '2025-10-08 18:19:00', 1),
(35, 'Samsung Galaxy Z Flip7 5G 12GB 256GB', '1773989910979_shopping__1_.webp', 'Galaxy Z Flip 7 là thế hệ điện thoại gập mới sở hữu màn hình ngoài lớn 4.1 inch, thiết kế thời thượng cùng bộ sưu tập màu sắc trẻ trung. Viên pin 4300mAh kết hợp chip Exynos 2500 cho hiệu năng mạnh mẽ, xử lý mượt mà các tác vụ AI. Đây chính là trợ lý thông minh nhỏ gọn, phù hợp với người dùng yêu công nghệ và thời trang.', 26590, 30590, 100, 103, 1, '2025-10-08 18:20:43', 1),
(36, 'iPhone 16 Pro Max 256GB', '1773989933200_download.webp', '', 30590, 89000, 100, 103, 1, '2025-10-08 18:23:32', 1),
(37, 'Xiaomi Poco X7 5G 12GB 512GB', '1773989967657_download__20_.jpg', 'Với những gì được trang bị, POCO X7 5G dễ dàng trở thành lựa chọn nổi bật trong tầm giá dưới 10 triệu đồng. Từ thiết kế sang trọng, màn hình xuất sắc, hiệu năng mạnh mẽ đến pin trâu, máy hội tụ đầy đủ các yếu tố mà người dùng mong đợi. Đây là sản phẩm lý tưởng cho cả người dùng phổ thông, sinh viên đến dân công nghệ.', 7890, 10890, 100, 100, 1, '2025-10-08 18:25:27', 1),
(38, 'Xiaomi Redmi Pad SE 8.7 WiFi 4GB 128GB', '1773990004430_download__21_.jpg', 'Redmi Pad SE 8.7 sở hữu thiết kế gọn nhẹ nhưng vẫn đáp ứng được sức mạnh mà người dùng yêu cầu. Màn hình 8.7 inch này còn mang đến trải nghiệm liền mạch và an toàn cho mắt. Hãy để thiết bị cùng bạn chinh phục mọi thử thách, công việc mỗi ngày.', 2690, 3890, 100, 102, 2, '2025-10-08 18:27:10', 1),
(39, 'Samsung Galaxy Tab A9 WiFi 8GB 128GB', '1773990129382_download__22_.jpg', 'Samsung Galaxy Tab A9 WiFi không chỉ là một thiết bị giải trí mà còn là một công cụ làm việc hiệu quả. Với hàng loạt tính năng nổi bật và giá bán rất phải chăng, không khó hiểu khi sản phẩm này trở thành lựa chọn hàng đầu của nhiều người dùng.\r\n\r\nSamsung Galaxy Tab A9 WiFi\r\nMàn hình TFT LCD 8.7 inch\r\nĐối với mọi thiết bị di động, màn hình là nơi mà người dùng tương tác nhiều nhất. Hiểu được điều đó, Samsung đã trang bị một màn hình TFT LCD 8.7 inch cho Galaxy Tab A9 WiFi. Màn hình này không chỉ lớn về kích thước mà còn sắc nét về chất lượng.\r\n\r\nVới độ phân giải 1340 x 800 pixels và tần số làm mới 60Hz, mỗi hình ảnh, video hay trò chơi bạn xem trên màn hình này đều sẽ trở nên mượt mà, sống động, đem đến cho người dùng trải nghiệm hiển thị không giới hạn và đẳng cấp.', 3190, 4350, 100, 101, 2, '2025-10-08 18:30:00', 1),
(40, 'Honor Pad X9a WiFi 6GB 128GB', '1773990157135_download__23_.jpg', 'Với chiếc máy tính bảng Pad X9a, đội ngũ HONOR đã đạt được điểm cân bằng lý tưởng giữa hiệu suất làm việc và trải nghiệm giải trí. Sản phẩm sở hữu màn hình 11.5 inch rộng rãi với độ phân giải 2508 x 1504 pixels, tần số quét 120Hz và hệ thống 4 loa mạnh mẽ. Mẫu máy tính bảng này hướng đến trải nghiệm nghe nhìn mượt mà, sống động.', 5990, 7890, 100, 101, 2, '2025-10-08 18:31:50', 1),
(47, 'Laptop Acer Aspire Lite 15 AL15-41P-R3U5 R7 5700U/16GB/512GB/15.6', '1773990814044_download__33_.jpg', 'Phát huy những giá trị làm nên tên tuổi của dòng Aspire Lite, phiên bản Acer Aspire Lite 15 AL15-41P-R3U5 trở thành lựa chọn hàng đầu trong tầm giá dưới 15 triệu đồng. Sản phẩm sở hữu thiết kế mỏng nhẹ thanh lịch, màn hình Full HD sắc nét, hiệu năng mạnh mẽ nhờ chip Ryzen 7 5700U, RAM 16GB, SSD 512GB và hệ thống cổng kết nối phong phú.', 12690, 16789, 100, 100, 3, '2025-10-08 18:45:07', 1),
(48, 'Màn hình MSI Pro MP225V/21.5inch FHD(1920x1080)/VA 100Hz', '1773990773521_download__32_.jpg', 'Lên kệ với mức giá vừa túi tiền, MSI Pro MP225V 21.5 inch là mẫu màn hình văn phòng rất đáng sở hữu. Sản phẩm được trang bị tấm nền IPS độ phân giải Full HD sắc nét, có tần số quét 100Hz mượt mà và nhiều công nghệ bản vệ mắt. Đây là lựa chọn tốt để phục vụ công việc đồng thời đáp ứng nhu cầu giải trí cơ bản.', 1590, 2900, 100, 100, 4, '2025-10-08 18:48:26', 1),
(49, 'Màn hình MSI MP251 E2/24.5 inch FullHD (1920x1080)/IPS 120Hz', '1773990726647_download__31_.jpg', 'Được thiết kế tối ưu dành cho các tác vụ văn phòng, màn hình MSI MP251 E2 24.5 inch đem đến sự hỗ trợ chuyên nghiệp nhất trên bàn làm việc của bạn. Sản phẩm không chỉ cung cấp trải nghiệm hình ảnh sắc nét mà còn có thiết kế đậm chất thanh lịch. Bộ công nghệ bảo vệ mắt đem lại cảm nhận dễ chịu khi nhìn ngắm.', 9000, 19900, 100, 102, 4, '2025-10-08 18:50:22', 1),
(50, 'Màn hình Xiaomi A27i EU(ELA5345EU)/27 inch/FullHD (1920x1080)/IPS 100Hz', '1773990699466_download__30_.jpg', 'Bên trong thiết kế tối giản và chuyên nghiệp của màn hình Xiaomi A27i là tấm nền IPS cho góc nhìn rộng mở. Sản phẩm có tần số quét cao 100Hz, đảm bảo trải nghiệm tốt cho cả công việc và giải trí, độ phân giải Full HD và khả năng hiển thị màu sắc đạt 99% chuẩn sRGB sẽ đem lại những khuôn hình sống động, sắc nét đáng kinh ngạc.', 10090, 15098, 100, 202, 4, '2025-10-08 18:52:41', 1),
(51, 'Màn hình Viewsonic VA2214-H/21.5inch FHD (1920x1080)/IPS 100Hz', '1773990675106_download__29_.jpg', 'Với mức giá rất dễ tiếp cận, màn hình ViewSonic VA2214-H đem lại sự hỗ trợ tốt hơn cho trải nghiệm công việc, học tập và giải trí của bạn. Sản phẩm có kích thước 21.5 inch, độ phân giải Full HD và tần số quét 100Hz. Viewsonic đã tích hợp thêm công nghệ bảo vệ mắt Eye ProTech nhằm mang lại trải nghiệm hình ảnh thân thiện và dễ chịu khi sử dụng lâu dài.', 2980, 3980, 100, 101, 4, '2025-10-08 18:55:32', 1),
(63, 'Samsung Smart TV Crystal UHD 43 inch 4K UA43DU7000', '1773990454974_download__28_.jpg', 'Samsung Smart TV Crystal UHD 43 inch 4K UA43DU7000 là dòng tivi hiện đại, tạo ra trải nghiệm giải trí sống động với chất lượng hình ảnh vượt trội. Bên cạnh đó, thiết bị này tích hợp công nghệ Q-Symphony, mang đến hiệu ứng âm thanh vòm sống động khi xem phim, nghe nhạc hoặc chơi game. Với hệ điều hành Samsung Tizen, tivi cung cấp kho ứng dụng phong phú, cho phép người dùng tận hưởng những chương trình yêu thích suốt cả ngày.\r\n\r\nViền siêu mỏng, mở rộng khung hình hiển thị\r\nSamsung Smart TV Crystal UHD 43 inch 4K UA43DU7000 sở hữu thiết kế viền siêu mỏng, giúp mở rộng không gian hiển thị và mang đến trải nghiệm xem hoàn hảo. Nhờ đó, người xem có thể tập trung theo dõi nội dung đang phát mà không bị xao nhãng. Ngoài ra, tivi còn trang bị chân đế chắc chắn, hỗ trợ thiết bị đứng vững vàng trên kệ hay mặt phẳng. Nếu muốn tiết kiệm diện tích, bạn có thể treo tivi lên tường để tối ưu không gian trong nhà.', 6400, 7890, 100, 101, 34, '2025-10-09 10:26:36', 1),
(64, 'Xiaomi Google TV 32 inch HD A L32M8-P2SEA', '1773990421563_download__27_.jpg', 'Xiaomi Google TV A 32 inch sẽ mang tới cho bạn những trải nghiệm tuyệt vời với mức giá cực kỳ phải chăng. Sản phẩm sở hữu tấm nền HD 32 inch, có thể diễn đạt tới 16 triệu màu sống động. Ngoài ra, cụm loa ngoài 5W + 5W, công nghệ Dolby Audio và hệ thống Google TV cũng hứa hẹn những phút giây giải trí tuyệt vời cho người dùng.', 3920, 4320, 100, 101, 34, '2025-10-09 10:30:41', 1),
(65, 'Casper Google TV 43 inch Full HD 43FGK610', '1773990395736_download__26_.jpg', 'Casper Google Tivi FHD 43 inch 43FGK610 nổi bật với thiết kế tràn viền đẹp mắt, mang đến cho người dùng trải nghiệm xem rộng lớn và đắm chìm. Không những thế, thiết bị này còn trang bị ảnh sắc nét, âm thanh sống động cùng với đó là hệ điều hành thông minh và trợ lý ảo tích hợp. Đây chắc chắn là một lựa chọn lý tưởng cho những ai đang tìm kiếm một chiếc tivi vừa chất lượng vừa hiện đại.\r\n\r\nMàn hình tràn viền ấn tượng, hiển thị rộng rãi\r\nMột trong những điểm nhấn của Casper Google Tivi FHD 43 inch 43FGK610 chính là thiết kế màn hình tràn viền ấn tượng. Phần viền được tối ưu hóa về kích thước, tạo nên một không gian hiển thị rộng rãi, giúp người xem tập trung hơn vào nội dung mà không bị xao lãng bởi những yếu tố bên ngoài khác.\r\n\r\nThiết kế này không chỉ tạo điểm nhấn cho không gian nội thất mà còn mang lại trải nghiệm xem phim, nghe nhạc hay chơi game trở nên sống động hơn. Đặc biệt, độ phân giải Full HD trên màn hình 43 inch chắc chắn sẽ tái hiện rõ nét từng chi tiết của hình ảnh, từ đó nâng cao chất lượng trải nghiệm của người dùng.', 4990, 5690, 100, 101, 34, '2025-10-09 10:34:07', 1),
(66, 'Tủ lạnh Mini Aqua 90 lít AQR-D100FA(BS)', '1773990289777_download__25_.jpg', '', 3900, 4100, 100, 101, 35, '2025-10-09 10:39:03', 1),
(67, 'Tủ lạnh Mini Hisense 94 lít HR09DB', '1773990182958_download__24_.jpg', '', 1900, 2389, 100, 100, 35, '2025-10-09 10:41:08', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `role`, `address`, `created_at`, `image`, `name`, `phone`, `updated_at`) VALUES
(23, 'admin@gmail.com', '$2a$10$XHpGE4IrpNNweKDaXfKi.e8XPTCAnppot5jpO80TRV9bH56PUZLde', 'admin', NULL, NULL, NULL, NULL, '', NULL),
(24, 'hau99082005@gmail.com', '$2a$10$RdImd0HYGT/x/pCZFpuZG.Egd6tWpcYlvb7oWuoKstshSOp4apSwi', 'admin', NULL, '2026-03-20 06:55:36.000000', NULL, 'Hậu Văn Hậu Lê', '0367722789', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `banner`
--
ALTER TABLE `banner`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `blog_detail`
--
ALTER TABLE `blog_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`);

--
-- Chỉ mục cho bảng `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  ADD UNIQUE KEY `UKdu5v5sr43g5bfnji4vb8hg5s3` (`phone`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `banner`
--
ALTER TABLE `banner`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `blog`
--
ALTER TABLE `blog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT cho bảng `blog_detail`
--
ALTER TABLE `blog_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT cho bảng `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `blog_detail`
--
ALTER TABLE `blog_detail`
  ADD CONSTRAINT `blog_detail_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blog` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
