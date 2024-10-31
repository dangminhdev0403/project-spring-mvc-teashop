package com.minh.teashop.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.minh.teashop.domain.User;
import com.minh.teashop.domain.verifymail.VerificationToken;
import com.minh.teashop.domain.verifymail.VerificationTokenUtil;
import com.minh.teashop.repository.VerificationTokenRepository;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    private VerificationTokenUtil tokenUtil;

    @Autowired
    private VerificationTokenRepository tokenRepository;
    
    @Autowired
    private UserService userService ;


    public VerificationToken findByToken(String token){
        return this.tokenRepository.findByToken(token);
    } 


    public void  handleEnableUser(VerificationToken token){
        User user = token.getUser();
        user.setEnabled(true);
        userService.handleSaveUser(user) ;
        tokenRepository.delete(token);
    }



    public void sendEmailVerify(User user) throws MessagingException {

        String token = tokenUtil.generateToken();

        LocalDateTime expiryDate = tokenUtil.calculateExpiryDate();

        VerificationToken verificationToken = new VerificationToken();

        verificationToken.setUser(user);
        verificationToken.setExpiryDate(expiryDate);
        verificationToken.setToken(token);
        this.tokenRepository.save(verificationToken);

        String verificationUrl = ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/verify")
                .queryParam("token", token) // Thay bằng token thực tế
                .toUriString();

        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
        String subject = "Xác thực tài khoản";
        String content = createEmailContent(verificationUrl);

        helper.setTo(user.getEmail());
        helper.setSubject(subject);
        helper.setText(content, true);

        mailSender.send(message);
    }

    private String createEmailContent(String url) {
        // Gán nội dung HTML vào biến text
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<title></title>" +
                "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />" +
                "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">" +
                "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />" +
                "<style type=\"text/css\">" +
                "@media screen { " +
                "@font-face { " +
                "font-family: 'Lato'; " +
                "font-style: normal; " +
                "font-weight: 400; " +
                "src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v11/qIIYRU-oROkIk8vfvxw6QvesZW2xOQ-xsNqO47m55DA.woff) format('woff'); "
                +
                "} " +
                "@font-face { " +
                "font-family: 'Lato'; " +
                "font-style: normal; " +
                "font-weight: 700; " +
                "src: local('Lato Bold'), local('Lato-Bold'), url(https://fonts.gstatic.com/s/lato/v11/qdgUG4U09HnJwhYI-uK18wLUuEpTyoUstqEm5AMlJo4.woff) format('woff'); "
                +
                "} " +
                "@font-face { " +
                "font-family: 'Lato'; " +
                "font-style: italic; " +
                "font-weight: 400; " +
                "src: local('Lato Italic'), local('Lato-Italic'), url(https://fonts.gstatic.com/s/lato/v11/RYyZNoeFgb0l7W3Vu1aSWOvvDin1pK8aKteLpeZ5c0A.woff) format('woff'); "
                +
                "} " +
                "@font-face { " +
                "font-family: 'Lato'; " +
                "font-style: italic; " +
                "font-weight: 700; " +
                "src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(https://fonts.gstatic.com/s/lato/v11/HkF_qI1x_noxlxhrhMQYELO3LdcAZYWl9Si6vvxL-qU.woff) format('woff'); "
                +
                "} " +
                "} " +
                "body, table, td, a { " +
                "-webkit-text-size-adjust: 100%; " +
                "-ms-text-size-adjust: 100%; " +
                "} " +
                "table, td { " +
                "mso-table-lspace: 0pt; " +
                "mso-table-rspace: 0pt; " +
                "} " +
                "img { " +
                "-ms-interpolation-mode: bicubic; " +
                "} " +
                "img { " +
                "border: 0; " +
                "height: auto; " +
                "line-height: 100%; " +
                "outline: none; " +
                "text-decoration: none; " +
                "} " +
                "table { " +
                "border-collapse: collapse !important; " +
                "} " +
                "body { " +
                "height: 100% !important; " +
                "margin: 0 !important; " +
                "padding: 0 !important; " +
                "width: 100% !important; " +
                "} " +
                "a[x-apple-data-detectors] { " +
                "color: inherit !important; " +
                "text-decoration: none !important; " +
                "font-size: inherit !important; " +
                "font-family: inherit !important; " +
                "font-weight: inherit !important; " +
                "line-height: inherit !important; " +
                "} " +
                "@media screen and (max-width:600px) { " +
                "h1 { " +
                "font-size: 32px !important; " +
                "line-height: 32px !important; " +
                "} " +
                "} " +
                "div[style*=\"margin: 16px 0;\"] { " +
                "margin: 0 !important; " +
                "} " +
                "</style>" +
                "</head>" +
                "<body style=\"background-color: #f4f4f4; margin: 0 !important; padding: 0 !important;\">" +
                "<div style=\"display: none; font-size: 1px; color: #fefefe; line-height: 1px; font-family: 'Lato', Helvetica, Arial, sans-serif; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden;\"> Chúng tôi rất vui mừng khi có bạn ở đây! Hãy sẵn sàng để khám phá tài khoản mới của bạn.</div>"
                +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">" +
                "<tr>" +
                "<td bgcolor=\"#77DAE6\" align=\"center\">" +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">" +
                "<tr>" +
                "<td align=\"center\" valign=\"top\" style=\"padding: 40px 10px 40px 10px;\"> </td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#77DAE6\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">" +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">" +
                "<tr>" +
                "<td bgcolor=\"#ffffff\" align=\"center\" valign=\"top\" style=\"padding: 40px 20px 20px 20px; border-radius: 4px 4px 0px 0px; color: #111111; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;\">"
                +
                "<h1 style=\"font-size: 48px; font-weight: 400; margin: 2;\">Chào mừng!</h1> <img src=\"https://img.icons8.com/clouds/100/000000/handshake.png\" width=\"125\" height=\"120\" style=\"display: block; border: 0px;\" />"
                +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">" +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">" +
                "<tr>" +
                "<td bgcolor=\"#ffffff\" align=\"left\" style=\"padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;\">"
                +
                "<p style=\"margin: 0;\">Chào mừng bạn đã tham gia cộng đồng. Trước tiên, bạn cần xác nhận tài khoản của mình. Chỉ cần nhấn vào nút bên dưới.</p>"
                +
                "<p style=\"margin: 0;\">Lưu ý ! Liên kết xác nhận email của bạn sẽ hết hiệu lực sau 30 phút.</p>" +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#ffffff\" align=\"left\">" +
                "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">" +
                "<tr>" +
                "<td align=\"center\">" +
                "<a href=\"" + url
                + "\" target=\"_blank\" style=\"background-color: #77DAE6; color: #ffffff; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 20px; font-weight: bold; padding: 15px 30px; border: 1px solid #77DAE6; display: inline-block;\">Xác nhận tài khoản</a>"
                +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#ffffff\" align=\"left\" style=\"padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;\">"
                +
                "<p style=\"margin: 0;\">Nếu bạn không yêu cầu xác nhận tài khoản này, hãy bỏ qua email này.</p>" +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">" +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">" +
                "<tr>" +
                "<td bgcolor=\"#77DAE6\" align=\"center\" style=\"padding: 30px 10px; border-radius: 0px 0px 4px 4px; color: #ffffff; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 14px; font-weight: 400; line-height: 18px;\">"
                +
                "<p style=\"margin: 0;\">© 2024 <a href=\"#\" style=\"color: #ffffff; text-decoration: none;\">Công ty của bạn</a>. Bản quyền thuộc về bạn.</p>"
                +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</body>" +
                "</html>";
    }

    private String createResetPass(String url) {
        // Gán nội dung HTML vào biến text
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<title></title>" +
                "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />" +
                "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">" +
                "<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />" +
                "<style type=\"text/css\">" +
                "@media screen { " +
                "@font-face { " +
                "font-family: 'Lato'; " +
                "font-style: normal; " +
                "font-weight: 400; " +
                "src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v11/qIIYRU-oROkIk8vfvxw6QvesZW2xOQ-xsNqO47m55DA.woff) format('woff'); "
                +
                "} " +
                "@font-face { " +
                "font-family: 'Lato'; " +
                "font-style: normal; " +
                "font-weight: 700; " +
                "src: local('Lato Bold'), local('Lato-Bold'), url(https://fonts.gstatic.com/s/lato/v11/qdgUG4U09HnJwhYI-uK18wLUuEpTyoUstqEm5AMlJo4.woff) format('woff'); "
                +
                "} " +
                "@font-face { " +
                "font-family: 'Lato'; " +
                "font-style: italic; " +
                "font-weight: 400; " +
                "src: local('Lato Italic'), local('Lato-Italic'), url(https://fonts.gstatic.com/s/lato/v11/RYyZNoeFgb0l7W3Vu1aSWOvvDin1pK8aKteLpeZ5c0A.woff) format('woff'); "
                +
                "} " +
                "@font-face { " +
                "font-family: 'Lato'; " +
                "font-style: italic; " +
                "font-weight: 700; " +
                "src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(https://fonts.gstatic.com/s/lato/v11/HkF_qI1x_noxlxhrhMQYELO3LdcAZYWl9Si6vvxL-qU.woff) format('woff'); "
                +
                "} " +
                "} " +
                "body, table, td, a { " +
                "-webkit-text-size-adjust: 100%; " +
                "-ms-text-size-adjust: 100%; " +
                "} " +
                "table, td { " +
                "mso-table-lspace: 0pt; " +
                "mso-table-rspace: 0pt; " +
                "} " +
                "img { " +
                "-ms-interpolation-mode: bicubic; " +
                "} " +
                "img { " +
                "border: 0; " +
                "height: auto; " +
                "line-height: 100%; " +
                "outline: none; " +
                "text-decoration: none; " +
                "} " +
                "table { " +
                "border-collapse: collapse !important; " +
                "} " +
                "body { " +
                "height: 100% !important; " +
                "margin: 0 !important; " +
                "padding: 0 !important; " +
                "width: 100% !important; " +
                "} " +
                "a[x-apple-data-detectors] { " +
                "color: inherit !important; " +
                "text-decoration: none !important; " +
                "font-size: inherit !important; " +
                "font-family: inherit !important; " +
                "font-weight: inherit !important; " +
                "line-height: inherit !important; " +
                "} " +
                "@media screen and (max-width:600px) { " +
                "h1 { " +
                "font-size: 32px !important; " +
                "line-height: 32px !important; " +
                "} " +
                "} " +
                "div[style*=\"margin: 16px 0;\"] { " +
                "margin: 0 !important; " +
                "} " +
                "</style>" +
                "</head>" +
                "<body style=\"background-color: #f4f4f4; margin: 0 !important; padding: 0 !important;\">" +
                "<div style=\"display: none; font-size: 1px; color: #fefefe; line-height: 1px; font-family: 'Lato', Helvetica, Arial, sans-serif; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden;\"> Yêu cầu reset mật khẩu cho tài khoản của bạn.</div>"
                +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">" +
                "<tr>" +
                "<td bgcolor=\"#77DAE6\" align=\"center\">" +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">" +
                "<tr>" +
                "<td align=\"center\" valign=\"top\" style=\"padding: 40px 10px 40px 10px;\"> </td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#77DAE6\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">" +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">" +
                "<tr>" +
                "<td bgcolor=\"#ffffff\" align=\"center\" valign=\"top\" style=\"padding: 40px 20px 20px 20px; border-radius: 4px 4px 0px 0px; color: #111111; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;\">"
                +
                "<h1 style=\"font-size: 48px; font-weight: 400; margin: 2;\">Đặt lại mật khẩu!</h1> <img src=\"https://img.icons8.com/clouds/100/000000/lock.png\" width=\"125\" height=\"120\" style=\"display: block; border: 0px;\" />"
                +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">" +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">" +
                "<tr>" +
                "<td bgcolor=\"#ffffff\" align=\"left\" style=\"padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;\">"
                +
                "<p style=\"margin: 0;\">Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Để đặt lại mật khẩu, vui lòng nhấn vào nút bên dưới.</p>"
                +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#ffffff\" align=\"left\">" +
                "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">" +
                "<tr>" +
                "<td align=\"center\">" +
                "<a href=\"" + url
                + "\" target=\"_blank\" style=\"background-color: #77DAE6; color: #ffffff; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 20px; font-weight: bold; padding: 15px 30px; border: 1px solid #77DAE6; display: inline-block;\">Đặt lại mật khẩu</a>"
                +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#ffffff\" align=\"left\" style=\"padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;\">"
                +
                "<p style=\"margin: 0;\">Nếu bạn không yêu cầu đặt lại mật khẩu này, hãy bỏ qua email này.</p>" +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "<tr>" +
                "<td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">" +
                "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">" +
                "<tr>" +
                "<td bgcolor=\"#77DAE6\" align=\"center\" style=\"padding: 30px 10px; border-radius: 0px 0px 4px 4px; color: #ffffff; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 14px; font-weight: 400; line-height: 18px;\">"
                +
                "<p style=\"margin: 0;\">© 2024 <a href=\"#\" style=\"color: #ffffff; text-decoration: none;\">Công ty của bạn</a>. Bản quyền thuộc về bạn.</p>"
                +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</td>" +
                "</tr>" +
                "</table>" +
                "</body>" +
                "</html>";
    }
}