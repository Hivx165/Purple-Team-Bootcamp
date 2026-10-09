# SOC Incident Report — SSH Brute-Force Investigation

## 1. Incident Summary

phát hiện nhiều lần SSH authentication failure, có dấu hiệu brute-force

## 2. Envidence

- total log entires : 10
- failed SSH attemps : 9
- successfull SSH attemps : 1
- sources IPs with failed attemps : 3
- targeted accounts : root, admin, test

## 3. Top source IP

- IP : 192.168.1.50
- Failed attemps : 4

## 4. Target accounts

- root : 5 failed attemps
- admin : 3 failed attemps
- test : 1 failed attemps

## 5. Successful Login

- user : hieu
- source IP : 192.168.1.100
- result : accepted password
- assessment : chưa xác định được đây có phải hoạt động hợp lệ không

## 6. Analysis

có nhiều lần xác thực thất bại từ 3 ip nguồn, nhắm tới các tài khoản root, admin, test. Các sự kiện này phù hợp với dấu hiệu brute-force.

## 7. Assessment

Phát hiện hoạt động tấn công dò mật khẩu SSH (brute-force) đáng ngờ

## 8. Conclusion

có dấu hiệu SSH brute-force. Tuy nhiên, chưa có bằng chứng cho thấy một trong các IP nguồn thất bại đã đăng nhập thành công hoặc máy chủ đã bị compromise

## 9. Recommended Actions

- kiểm tra thêm SSH authentication logs
- xác minh hoạt động của các IP nguồn đáng nghi
- kiểm tra xem đăng nhập thành công của user hieu có được ủy quyền hay không
- rà soát hoạt động của các tài khoản bị nhắm tới
- cân nhắc tăng cường bảo mật SSH phù hợp với môi trường
