# Thư mục video bài giảng

Đặt file video vào đây là học viên xem thẳng trong app, không qua YouTube hay
web nào khác.

## Đặt tên

Theo mẫu `chuong<số>-bai<số>.mp4`, ví dụ:

```
videos/chuong3-bai5.mp4      → Chương 3, Bài 5 (Điệu Disco)
videos/chuong4-bai7.mp4      → Chương 4, Bài 7 (Điệu Ballad)
```

Rồi mở `index.html`, tìm bài đó trong mảng `LESSONS` và điền vào ô `video`:

```js
{n:13, ch:3, no:5, t:"Điệu Disco (2/4)", ..., video:"videos/chuong3-bai5.mp4"},
```

## Nén trước khi bỏ vào đây

Video quay từ điện thoại thường 200-500MB một bài — **quá nặng**, GitHub chặn
file trên 100MB và cả site chỉ được 1GB. Chạy `nen-video.ps1` ở thư mục gốc
để nén xuống 720p:

```powershell
.\nen-video.ps1 -InputFile "D:\quay\bai5.mp4" -Output "videos\chuong3-bai5.mp4"
```

Một bài 5 phút sau khi nén thường còn khoảng 25-40MB.

## Ba giới hạn phải nhớ

| | Giới hạn |
|---|---|
| Một file | **100MB** — vượt là GitHub từ chối push |
| Cả site | **1GB** |
| Băng thông | **100GB/tháng** |

Với 33 bài thì trung bình mỗi bài chỉ được ~30MB. Bài nào dài quá 8-10 phút
sẽ không vừa.

**Khi nào phải đổi cách:** nếu tổng video vượt 1GB, hoặc lượng học viên xem
nhiều làm vượt 100GB/tháng, thì chuyển video sang dịch vụ lưu trữ (Cloudflare
R2 rẻ nhất, 10GB đầu miễn phí và không tính phí băng thông ra). Lúc đó chỉ cần
đổi ô `video` từ `"videos/chuong3-bai5.mp4"` thành link đầy đủ
`"https://..."` — **không phải sửa code**, app tự nhận.
