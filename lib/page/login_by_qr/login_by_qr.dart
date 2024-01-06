import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:qr_flutter/qr_flutter.dart";
import "package:sales_management/component/adapt/fetch_api.dart";
import "package:sales_management/component/loading_overlay_alt.dart";
import "package:sales_management/page/account/api/model/token.dart";
import "package:sales_management/page/login_by_qr/api/list_tokens_result.dart";
import "package:sales_management/page/login_by_qr/api/tokens_api.dart";
import "package:sales_management/page/login_by_qr/component/login_by_qr_bar.dart";
import "package:sales_management/utils/constants.dart";
import "package:sales_management/utils/snack_bar.dart";
import "package:sales_management/utils/utils.dart";

class LoginByQR extends StatelessWidget {
  const LoginByQR({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingOverlayAlt(
      child: Builder(builder: (context) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: White,
            resizeToAvoidBottomInset: false,
            appBar: StoreInfoBar(),
            body: FetchAPI<ListTokensResult>(
              future: getAllTokens(),
              successBuilder: (ListTokensResult) {
                final token = ListTokensResult.getActiveToken();
                if (token == null) {
                  return FetchAPI<Token>(
                    future: createToken(generateUUID()),
                    successBuilder: (tk) {
                      return _QrContent(
                        token: tk,
                      );
                    },
                  );
                }
                return _QrContent(token: token);
              },
            ),
          ),
        );
      }),
    );
  }
}

class _QrContent extends StatelessWidget {
  final Token token;
  const _QrContent({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    final code = token.tokenSecondId ?? 'empty';
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: code,
                    ),
                  );
                  showNotification(context, 'Copy token!');
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Chú ý: bất kỳ ai có mã này đều có thể đăng nhập như là chủ của cửa hàng, có thể chỉnh sửa dữ liệu của cửa hàng!!',
                      softWrap: true,
                      style: customerNameBigRed,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    QrImageView(
                      data: code,
                      size: 300,
                      gapless: false,
                      embeddedImage:
                          AssetImage('assets/images/app_logo_50.png'),
                      errorStateBuilder: (cxt, err) {
                        return const Center(
                          child: Text(
                            'Uh oh! Something went wrong...',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      code,
                      style: headStyleXLarge400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
