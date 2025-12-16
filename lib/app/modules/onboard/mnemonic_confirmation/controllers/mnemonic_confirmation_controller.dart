// Copyright (c) 2025, one of DanhDue ExOICTIF projects. All rights reserved.

import 'package:d3_wallet/base/base_controller.dart';
import 'package:d3_wallet/data/bean/mnemonic_info_object/mnemonic_info_object.dart';
import 'package:d3_wallet/data/bean/response/wallet_response_object/wallet_response_object.dart';
import 'package:d3_wallet/data/repositories/wallet_repository.dart';
import 'package:d3_wallet/utils/constants.dart';
import 'package:d3_wallet/utils/extensions/string_ext.dart';
import 'package:dart_extensions/dart_extensions.dart';
import 'package:fimber/fimber.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_utils/src/extensions/num_extensions.dart';

class MnemonicConfirmationController extends BaseController {
  final secretRecoveryPhraseIsGenerated = false.obs;
  late final Rx<WalletResponseObject?> wallet = WalletResponseObject().obs;
  final walletRepo = Get.find<WalletRepository>();

  static const int mnemonicWordCount = 12;
  static const int showWordCount = 4;

  final filledWords = <String?>[].obs;
  final allWords = <MnemonicInfoObject?>[].obs;
  final hiddenWords = <MnemonicInfoObject?>[].obs;
  final shownWordIndices = <int>[].obs;
  final hiddenWordIndices = <int>[].obs;
  final focusedIndex = (-1).obs;

  final mnemonicIsVerified = false.obs;
  final mnemonicIsFailure = false.obs;

  @override
  void onInit() {
    super.onInit();
    Fimber.d("onInit()");
  }

  @override
  void onReady() {
    super.onReady();
    Fimber.d("onInit()");
  }

  @override
  void onClose() {
    super.onClose();
    Fimber.d("onInit()");
  }

  void setupInputs(WalletResponseObject? createdWallet) {
    wallet.value = createdWallet;
    final words = wallet.value?.mnemonics?.split(Constants.spaceCharacter);
    _fillSixWordsIfExists(words);
  }

  _fillSixWordsIfExists(List<String>? words) {
    Fimber.d("mnemonic: ${wallet.value?.mnemonics}");
    filledWords.value = words ?? [];
    if (words != null && words.isNotEmpty == true) {
      // Random 6 words needed to cobime to mnemonic.
      List<int> randomIndices = List.generate(mnemonicWordCount, (index) => index)..shuffle();
      shownWordIndices.value = randomIndices.take(showWordCount).toList();

      hiddenWordIndices.value =
          randomIndices.where((index) => !shownWordIndices.contains(index)).toList();
      Fimber.d("remainIndices: $hiddenWordIndices");

      int minHiddenWordIndex = hiddenWordIndices.reduce((a, b) => a < b ? a : b);
      focusedIndex.value = minHiddenWordIndex;

      // prepare all words that contained bot empty and not empty word.
      allWords.value = List.filled(12, MnemonicInfoObject(), growable: true);
      for (int i = 0; i < shownWordIndices.length; i++) {
        int index = shownWordIndices[i];
        String word = words[index];
        allWords.removeAt(index);
        allWords.insert(
          index,
          MnemonicInfoObject(
            allWordsIndex: index,
            enterredIndex: index,
            word: word,
            enterWord: word,
            isHidden: false,
          ),
        );
      }

      // prepare hidden word list.
      final hiddenWordList = List<MnemonicInfoObject?>.empty(growable: true);
      for (int i = 0; i < hiddenWordIndices.length; i++) {
        int index = hiddenWordIndices[i];
        String word = words[index];
        allWords.removeAt(index);
        final hiddenWordItem = MnemonicInfoObject(
          hiddenWordIndex: i,
          allWordsIndex: index,
          word: word,
          isHidden: true,
        );
        allWords.insert(index, hiddenWordItem);
        hiddenWordList.add(hiddenWordItem);
      }
      hiddenWords.value = hiddenWordList;

      // update all words.
      allWords.value = allWords.value;
      allWords.refresh();
    }
  }

  void updateFocussedIndex(int index) {
    focusedIndex.value = index;
    mnemonicIsFailure.value = false;
    if (StringExt(allWords[index]?.enterWord)?.isNotBlank() == true) {
      mnemonicIsVerified.value = false;
      hiddenWords.add(allWords[index]?.copyWith(enterWord: null, enterredIndex: null));
      hiddenWordIndices.add(allWords[index]?.enterredIndex ?? -1);
      final removingWord = allWords[index];
      allWords.removeAt(index);
      final edittedWords = allWords.value;
      edittedWords.insert(index, removingWord?.copyWith(enterWord: null));
      allWords.value = allWords.value;
      hiddenWords.refresh();
      hiddenWordIndices.refresh();
      allWords.refresh();
    }
  }

  void hiddenWordIsSelected(int allWordIndex, int hiddenWordIndex) {
    Fimber.d("hiddenWordIsSelected(index: $allWordIndex)");
    final word = filledWords[allWordIndex];
    final updatedWord = allWords[focusedIndex.value];
    // update all words
    allWords.removeAt(focusedIndex.value);
    allWords.insert(
      focusedIndex.value,
      updatedWord?.copyWith(enterWord: word, enterredIndex: hiddenWordIndices[hiddenWordIndex]),
    );
    allWords.value = allWords.value;
    // remove hidden word on the bottom list.
    hiddenWordIndices.removeAt(hiddenWordIndex);
    hiddenWordIndices.value = hiddenWordIndices.value;
    allWords.refresh();
    hiddenWordIndices.refresh();

    // remove hidden word that existsed in the all words.
    hiddenWords.value.removeAt(hiddenWordIndex);
    hiddenWords.value = hiddenWords.value;

    // update focussed empty word in all words.
    final nextEmptyIndex = allWords.value.firstOrNullWhere((item) => item?.enterWord == null);
    focusedIndex.value = allWords.indexOf(nextEmptyIndex);
    if (focusedIndex.value == -1) {
      _checkMnemonics();
    }
  }

  _checkMnemonics() {
    Fimber.d("_checkMnemonics()");
    final combinedWord = allWords.map((e) => e?.enterWord ?? '').join(' ');
    Fimber.d("Combined mnemonic: $combinedWord");
    if (combinedWord == wallet.value?.mnemonics) {
      mnemonicIsVerified.value = true;
    } else {
      mnemonicIsVerified.value = false;
      mnemonicIsFailure.value = true;
    }
  }

  updateBackupState() async {
    isLoading.value = true;
    wallet.value = wallet.value?.copyWith(scrIsBackedUp: true, scrBackupReminderIsShown: true);
    final yourWallets = await walletRepo.retrieveYourWallets();
    final oldWallet = yourWallets?.firstOrNullWhere(
      (item) => item?.address == wallet.value?.address,
    );
    if (oldWallet != null) {
      final oldWalletIndex = yourWallets?.indexOf(oldWallet);
      if (oldWalletIndex?.isGreaterThan(-1) == true) {
        yourWallets?.removeAt(oldWalletIndex!);
        yourWallets?.insert(
          oldWalletIndex!,
          oldWallet.copyWith(scrIsBackedUp: true, scrBackupReminderIsShown: true),
        );
        await walletRepo.updateYourWallets(yourWallets);
      }
    }
    isLoading.value = false;
  }
}
