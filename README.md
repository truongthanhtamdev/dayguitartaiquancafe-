# Dạy Guitar Tại Quán Cà Phê

App học guitar đệm hát cho học viên, chạy hoàn toàn trong trình duyệt. Không
cần máy chủ, không cần đăng nhập, tiến độ lưu ngay trên máy học viên.

## Có gì

| Màn hình | Nội dung |
|---|---|
| **Hôm nay** | Buổi kế tiếp, chuỗi ngày luyện, số phút hôm nay, bài luyện 10 phút, thẻ lớp học |
| **Lộ trình** | 36 buổi chia 6 chặng, lọc theo chặng, đánh dấu hoàn thành |
| **Chi tiết buổi học** | Mục tiêu, kết quả, bài luyện ở nhà, hợp âm của buổi kèm mẹo bấm, nút mở đúng metronome và đúng điệu đệm |
| **Chi tiết lớp học** | Thông tin lớp, buổi kế tiếp, tiến độ gói buổi, nhật ký từng buổi |
| **Hợp âm** | 20 hợp âm vẽ sơ đồ thế bấm, chạm để nghe tiếng đàn |
| **Luyện tập** | Metronome, lên dây đàn bằng micro, máy đệm hát 5 điệu |

Lộ trình 36 buổi: làm quen đàn và nhịp → 14 hợp âm trưởng/thứ → Slow Rock →
Ballad → quạt chả → bài tốt nghiệp.

## Chạy thử

Mở thẳng `index.html` bằng trình duyệt là dùng được ngay.

Riêng phần **lên dây đàn** cần micro, mà trình duyệt chỉ cho phép truy cập
micro trên `https` hoặc `localhost`. Muốn thử tính năng đó ở máy:

```bash
python -m http.server 8000
```

rồi mở http://localhost:8000

## Đưa lên mạng

Bật GitHub Pages: **Settings → Pages → Source: Deploy from a branch → main /
(root)**. Vì Pages chạy trên `https` nên tuner hoạt động đầy đủ.

Học viên vào link đó rồi **Thêm vào màn hình chính** là có app trên điện
thoại — Android: menu ⋮ → *Cài đặt ứng dụng*; iPhone: nút Chia sẻ → *Thêm vào
MH chính*.

## Kỹ thuật

Một file HTML duy nhất, không phụ thuộc thư viện ngoài.

- **Tiếng đàn** tổng hợp bằng Karplus-Strong qua Web Audio, nên repo không
  cần chứa file âm thanh nào.
- **Metronome và máy đệm** dùng bộ lập lịch nhìn trước (lookahead scheduler):
  thời điểm phát do đồng hồ Web Audio quyết định nên nhịp không trôi khi tab
  bận.
- **Lên dây đàn** dò cao độ bằng tự tương quan chuẩn hoá (ACF2+), có nội suy
  đỉnh parabol để đủ mịn khi hiện sai số theo cent.
- **Sơ đồ hợp âm** vẽ bằng SVG sinh từ dữ liệu thế bấm, tự trượt cửa sổ ngăn
  khi hợp âm bấm cao hơn ngăn 4.
- **Tiến độ** lưu ở `localStorage`, khoá `dayguitarquancafe.v1`. Xoá dữ liệu
  trình duyệt là mất, nên có nút "Xuất tiến độ" ở màn Tôi.
