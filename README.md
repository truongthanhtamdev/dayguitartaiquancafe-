# Dạy Guitar Tại Quán Cà Phê

App học guitar đệm hát cho học viên, chạy hoàn toàn trong trình duyệt. Không
cần máy chủ, tiến độ lưu ngay trên máy học viên.

Giáo trình lấy theo khoá **Đệm hát cơ bản** trên
[guitardemhat.com](https://guitardemhat.com/courses/dem-hat-co-ban/): 6 chương,
33 bài, 8 điệu cơ bản.

## Có gì

| Màn hình | Nội dung |
|---|---|
| **Hôm nay** | Bài kế tiếp, chuỗi ngày luyện, số phút hôm nay, bài luyện 10 phút, thẻ lớp học |
| **Lộ trình** | 6 chương / 33 bài, lọc theo chương, đánh dấu hoàn thành |
| **Chi tiết bài học** | Video bài giảng, mục tiêu, kết quả, bài luyện, hợp âm của bài kèm mẹo bấm, nút mở đúng metronome và đúng điệu, link về bài gốc trên web |
| **Chi tiết lớp học** | Thông tin lớp, buổi kế tiếp, tiến độ gói buổi, nhật ký từng buổi |
| **Hợp âm** | 21 hợp âm vẽ sơ đồ thế bấm, chạm để nghe tiếng đàn |
| **Luyện tập** | Metronome, lên dây đàn bằng micro, máy đệm 8 điệu |
| **Tôi** | Đăng ký tài khoản (email + SĐT + khu vực), danh sách chi nhánh, thống kê |

## Ba chỗ cần sửa khi vận hành

Tất cả nằm trong khối **CẤU HÌNH** ở đầu thẻ `<script>` của `index.html`, ngay
đầu file cho dễ tìm.

### 1. Dán video bài giảng

Trong mảng `LESSONS`, mỗi bài có sẵn trường `video:""`. Điền vào là app tự hiện
trình phát ngay đầu trang bài học. Có hai cách:

**Cách A — YouTube (khuyên dùng).** Upload lên YouTube để chế độ **Không công
khai (Unlisted)**, rồi dán link vào:

```js
{n:13, ch:3, no:5, t:"Điệu Disco (2/4)", ..., video:"https://youtu.be/XXXXXXXXXXX"},
```

Nhận mọi dạng link: `youtu.be/...`, `youtube.com/watch?v=...`, `embed/...`,
`shorts/...`, `live/...`. Video vẫn phát **ngay trong app**, học viên không
phải rời trang.

App nhúng qua `youtube-nocookie.com` và tắt bớt phiền: `rel=0` giới hạn video
gợi ý cuối clip trong cùng kênh, `playsinline=1` để iPhone không nhảy ra toàn
màn hình, `iv_load_policy=3` tắt chú thích nổi.

Để **Riêng tư (Private)** thì không nhúng được — phải là Unlisted hoặc Công
khai.

**Cách B — để video ngay trong repo.** Không dính YouTube chút nào, nhưng
vướng giới hạn dung lượng của GitHub Pages:

```js
video:"videos/chuong3-bai5.mp4"
```

Phải nén trước bằng `nen-video.ps1` — xem giới hạn và hướng dẫn trong
[videos/README.md](videos/README.md). Chỉ hợp khi bài ngắn và ít bài.

Cũng nhận link file từ nơi khác (Cloudflare R2, VPS...):

```js
video:"https://media.tenmien.com/chuong3-bai5.mp4"
```

Đổi qua lại giữa các cách chỉ cần sửa ô `video`, không phải sửa code.

### 2. Nhận đăng ký của học viên

Mặc định `LEAD_ENDPOINT = ""` — học viên đăng ký thì thông tin **chỉ lưu trên
máy họ**, trung tâm không nhận được gì. Muốn nhận về một Google Sheet:

1. Tạo một Google Sheet mới, hàng đầu ghi 6 cột:
   `at | name | email | phone | area | source`
2. Vào **Tiện ích mở rộng → Apps Script**, xoá hết và dán:

   ```javascript
   function doPost(e) {
     const sh = SpreadsheetApp.getActiveSpreadsheet().getSheets()[0];
     const p = e.parameter;
     sh.appendRow([p.at, p.name, p.email, p.phone, p.area, p.source]);
     return ContentService.createTextOutput("ok");
   }
   ```
3. Bấm **Triển khai → Tuỳ chọn triển khai mới → Ứng dụng web**, chọn
   *Thực thi với tư cách: Tôi* và *Ai có quyền truy cập: Bất kỳ ai*.
4. Copy link web app rồi dán vào `LEAD_ENDPOINT` trong `index.html`.

Xong thì mỗi lần có người đăng ký, một dòng mới rơi vào Sheet — gọi tư vấn từ
đó. Học viên nào đăng ký lúc mất mạng thì app hiện "Đã lưu, chưa gửi", bấm
**Đăng ký / cập nhật** lần nữa là gửi lại.

### 3. Chi nhánh và khu vực

```js
const BRANCHES = [
  { name:"Chi nhánh Tân Phú", address:"Số 10 Đô Đốc Thủ, Tân Phú, TP.HCM", open:true }
];
```

Mở điểm mới thì thêm một dòng. Danh sách khu vực học viên chọn nằm ở `AREAS`,
có sẵn lựa chọn **Khu vực khác** để họ tự ghi.

## Chạy thử

Mở thẳng `index.html` bằng trình duyệt là dùng được ngay.

Riêng phần **lên dây đàn** cần micro, mà trình duyệt chỉ cho phép truy cập
micro trên `https` hoặc `localhost`:

```bash
python -m http.server 8000
```

rồi mở http://localhost:8000

## Đưa lên mạng

Bật GitHub Pages: **Settings → Pages → Source: Deploy from a branch → main /
(root)**. Repo phải để **Public** thì tài khoản GitHub Free mới chạy Pages.

Học viên vào link đó rồi **Thêm vào màn hình chính** là có app trên điện
thoại — Android: menu ⋮ → *Cài đặt ứng dụng*; iPhone: nút Chia sẻ → *Thêm vào
MH chính*.

## Kỹ thuật

Một file HTML duy nhất, không phụ thuộc thư viện ngoài.

- **Tiếng đàn** tổng hợp bằng Karplus-Strong qua Web Audio, nên repo không
  cần chứa file âm thanh nào.
- **Metronome và máy đệm** dùng bộ lập lịch nhìn trước: thời điểm phát do đồng
  hồ Web Audio quyết định nên nhịp không trôi khi tab bận. Mỗi điệu khai báo
  `beats` (số phách chính) và `sub` (số phách nhỏ) nên chạy đúng cho cả 2/4,
  3/4, 4/4 lẫn 6/8.
- **Lên dây đàn** dò cao độ bằng tự tương quan chuẩn hoá (ACF2+), có nội suy
  đỉnh parabol để đủ mịn khi hiện sai số theo cent.
- **Sơ đồ hợp âm** vẽ bằng SVG sinh từ dữ liệu thế bấm, tự trượt cửa sổ ngăn
  khi hợp âm bấm cao hơn ngăn 4.
- **Tiến độ** lưu ở `localStorage`, khoá `dayguitarquancafe.v1`. Xoá dữ liệu
  trình duyệt là mất, nên có nút "Xuất tiến độ" ở màn Tôi.
