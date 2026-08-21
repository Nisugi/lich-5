# Changelog

## [5.21.0](https://github.com/Nisugi/lich-5/compare/v5.20.1...v5.21.0) (2026-08-21)


### Features

* **all:** --bind-address speaks the same keywords as --detachable-client ([#1461](https://github.com/Nisugi/lich-5/issues/1461)) ([48e2296](https://github.com/Nisugi/lich-5/commit/48e229664b923be97b866c44d182bd10e920066e))
* **all:** Add active sessions API ([#1274](https://github.com/Nisugi/lich-5/issues/1274)) ([094c355](https://github.com/Nisugi/lich-5/commit/094c355c05a29eefc1ffc23a565b6505b0c6615a))
* **all:** add central method to determine lich ver ([#1417](https://github.com/Nisugi/lich-5/issues/1417)) ([12fd1c4](https://github.com/Nisugi/lich-5/commit/12fd1c4ebe8f2327c0f7fe9f5da2da99a5368a62))
* **all:** Add character generator support via EAccess protocol ([#1384](https://github.com/Nisugi/lich-5/issues/1384)) ([bf547a0](https://github.com/Nisugi/lich-5/commit/bf547a0ff9e624a6d0d46f69cdb5ecef8174a8bc))
* **all:** add concurrent runtime I/O and multi-client detach support ([#1459](https://github.com/Nisugi/lich-5/issues/1459)) ([44cb27e](https://github.com/Nisugi/lich-5/commit/44cb27ed15f4aaa0135de0ce19c389e3ab996bf0))
* **all:** add core classes, ScriptSync, and login auto-sync ([#1273](https://github.com/Nisugi/lich-5/issues/1273)) ([3ccdfb3](https://github.com/Nisugi/lich-5/commit/3ccdfb38076c5717f9bbdb867af77c26ba0fcdd7))
* **all:** Add forced script teardown command (06 of 06) ([#1479](https://github.com/Nisugi/lich-5/issues/1479)) ([8f0772d](https://github.com/Nisugi/lich-5/commit/8f0772dcdac73a7218f60989b342aec025e8f41b))
* **all:** Add Genie map cross-reference fields to the DragonRealms map data model ([#1169](https://github.com/Nisugi/lich-5/issues/1169)) ([1e7c1dd](https://github.com/Nisugi/lich-5/commit/1e7c1dde11025e5fe8bdbdf9f562f97bb4a84a2c))
* **all:** Add get_settings, get_data, start_scripts_if_available to core ([#1305](https://github.com/Nisugi/lich-5/issues/1305)) ([605aef5](https://github.com/Nisugi/lich-5/commit/605aef5a067e2082cded356cf885060b19e7815c))
* **all:** add InstanceSettings for core Settings API access ([#1233](https://github.com/Nisugi/lich-5/issues/1233)) ([6de17eb](https://github.com/Nisugi/lich-5/commit/6de17eb36119f78a34b8ba3f6ee4ac16e1071b9e))
* **all:** add macOS limited gem recovery ([#1448](https://github.com/Nisugi/lich-5/issues/1448)) ([70e8ef7](https://github.com/Nisugi/lich-5/commit/70e8ef74f830daa3784681901049f7d42e755c22))
* **all:** Add Map.apply_wayto_overrides for personal map overrides ([#1306](https://github.com/Nisugi/lich-5/issues/1306)) ([3e0169c](https://github.com/Nisugi/lich-5/commit/3e0169cebe07be1a70a0355144ee45fecd9b7f61))
* **all:** Add modern script command shutdown method ([#1385](https://github.com/Nisugi/lich-5/issues/1385)) ([04b4bf9](https://github.com/Nisugi/lich-5/commit/04b4bf9ccd93b7e6f25edb48b19c1b94b2e44f30))
* **all:** add roomlinks/roommono toggles for room display ([#1438](https://github.com/Nisugi/lich-5/issues/1438)) ([5baf15f](https://github.com/Nisugi/lich-5/commit/5baf15f3da2ac8b2b15b2be20a384e9b8f83b002))
* **all:** Add session status CLI query ([#1276](https://github.com/Nisugi/lich-5/issues/1276)) ([91e90f7](https://github.com/Nisugi/lich-5/commit/91e90f7c4c36cb1620c0c710acf59428172cd0ba))
* **all:** add simplified DB maintenance ([#991](https://github.com/Nisugi/lich-5/issues/991)) ([894f50d](https://github.com/Nisugi/lich-5/commit/894f50d451683a53d3eebc059aa8b5a8be7ac4ae))
* **all:** Add supervised child script APIs (01 of 06) ([#1474](https://github.com/Nisugi/lich-5/issues/1474)) ([6259b25](https://github.com/Nisugi/lich-5/commit/6259b25114b3068ee970bd62fa867f4fb3f67d43))
* **all:** configurable debug log retention ([#1282](https://github.com/Nisugi/lich-5/issues/1282)) ([03d908d](https://github.com/Nisugi/lich-5/commit/03d908d6fc433546095594fd27f955969e2803df))
* **all:** custom 3rd-party repo support for ScriptSync ([#1285](https://github.com/Nisugi/lich-5/issues/1285)) ([a2167fc](https://github.com/Nisugi/lich-5/commit/a2167fcb0936390ae38f26511ca8de24ffbb8f8d))
* **all:** gameobj.rb - add type? method for explicit type check ([#928](https://github.com/Nisugi/lich-5/issues/928)) ([cca16b6](https://github.com/Nisugi/lich-5/commit/cca16b6c84987530370b7f17104e90d55df8caf5))
* **all:** GUI Launcher Improvements ([#1463](https://github.com/Nisugi/lich-5/issues/1463)) ([0d209c7](https://github.com/Nisugi/lich-5/commit/0d209c7ef67aeb45281c576a0ff41a61cc39f7f5))
* **all:** keyword bind hosts for the detachable client (tailscale/lan/any) ([#1437](https://github.com/Nisugi/lich-5/issues/1437)) ([bfca33f](https://github.com/Nisugi/lich-5/commit/bfca33f7b2472079550de77d2d81583094acaf8c))
* **all:** Login modernization and refactor to yaml ([#1063](https://github.com/Nisugi/lich-5/issues/1063)) ([dda2bb6](https://github.com/Nisugi/lich-5/commit/dda2bb60eacf1b6e03ae0d6478d1d56fc4593cc1))
* **all:** Modify running? method to support optional exact matching of script names ([#1436](https://github.com/Nisugi/lich-5/issues/1436)) ([b9ae46f](https://github.com/Nisugi/lich-5/commit/b9ae46fe9aa3df4762f802634ec06b987e336b2f))
* **all:** Refocus Frontend ([#960](https://github.com/Nisugi/lich-5/issues/960)) ([72222d1](https://github.com/Nisugi/lich-5/commit/72222d1dd954b441da05717407823dfa45563872))
* **all:** Ruby Memory Releaser module ([#1066](https://github.com/Nisugi/lich-5/issues/1066)) ([038eef2](https://github.com/Nisugi/lich-5/commit/038eef21485e637a954acc355a34b2f0c502778b))
* **all:** self-healing gem requires ([#1439](https://github.com/Nisugi/lich-5/issues/1439)) ([dca2039](https://github.com/Nisugi/lich-5/commit/dca2039875b79e4a6c7c3e557f773b4ebcf54a5f))
* **all:** session summary store and reporting ([#1247](https://github.com/Nisugi/lich-5/issues/1247)) ([36ec701](https://github.com/Nisugi/lich-5/commit/36ec70170e7acb6e56c6da2e78d7fe6f08a7861a))
* **all:** setup_files: support scripts/data/custom for user data overrides ([#1431](https://github.com/Nisugi/lich-5/issues/1431)) ([13b82bc](https://github.com/Nisugi/lich-5/commit/13b82bc8c8576418bfcedac1c28374eb634d4cab))
* **all:** socket configurator to better guard TCPSocket ([#976](https://github.com/Nisugi/lich-5/issues/976)) ([f35034c](https://github.com/Nisugi/lich-5/commit/f35034ca69cddf4d0268b8f19fc5b76cc53a279a))
* **all:** teardown and distinguishable errors for Script.run_child ([#1501](https://github.com/Nisugi/lich-5/issues/1501)) ([65ace54](https://github.com/Nisugi/lich-5/commit/65ace5488cb014a8b014416f2d6b96665d5e4e3e))
* **all:** TextStripper module support for XML, HTML, Markdown ([#1055](https://github.com/Nisugi/lich-5/issues/1055)) ([7dc09b3](https://github.com/Nisugi/lich-5/commit/7dc09b3e3c3d9c3d229d68f5ea070d2a195b76ee))
* **all:** various Saga FE compatibility tweaks ([#1443](https://github.com/Nisugi/lich-5/issues/1443)) ([d407d8e](https://github.com/Nisugi/lich-5/commit/d407d8e76aff834d79ac9b241d119b047769dca2))
* **dr:** Add game flags and obsolete script warnings to DRInfomon startup ([#1307](https://github.com/Nisugi/lich-5/issues/1307)) ([4f1f5fb](https://github.com/Nisugi/lich-5/commit/4f1f5fbf7135d5c568369f4ebacb0cdcf5e4ae62))
* **dr:** Add GameObj.inv support for DR items ([#1080](https://github.com/Nisugi/lich-5/issues/1080)) ([c521917](https://github.com/Nisugi/lich-5/commit/c521917ac2a6d11296a0baa74ef4f17053e84f60))
* **dr:** Capture combat position from the balance status line ([#1400](https://github.com/Nisugi/lich-5/issues/1400)) ([5881e4a](https://github.com/Nisugi/lich-5/commit/5881e4a20d4b890eda46f3796bbece56bbe81185))
* **dr:** capture room UID from &lt;nav&gt; tag; stop enforcing ShowRoomID; opt-in room-id placement ([#1491](https://github.com/Nisugi/lich-5/issues/1491)) ([e5c852b](https://github.com/Nisugi/lich-5/commit/e5c852b07fde40334142fc2dc45dbf023273e8a9))
* **dr:** common-crafting add method for creating mechanisms ([#1375](https://github.com/Nisugi/lich-5/issues/1375)) ([a341bb1](https://github.com/Nisugi/lich-5/commit/a341bb1b174842056d6a32662ac4ccfe04c143b1))
* **dr:** common-healing.rb - add vitality parsing to HealthResult ([#1265](https://github.com/Nisugi/lich-5/issues/1265)) ([8a65de0](https://github.com/Nisugi/lich-5/commit/8a65de0d705a86c42b8fbbf6396f0f80232d32fc))
* **dr:** Decouple SetupFiles from script-scoped echo and XML feed timing ([#1304](https://github.com/Nisugi/lich-5/issues/1304)) ([56939e2](https://github.com/Nisugi/lich-5/commit/56939e2651b76a135c49c83b10a20e01b5ba74c5))
* **dr:** detect scheduled shutdown and expose it on DRParser ([#1409](https://github.com/Nisugi/lich-5/issues/1409)) ([1da0406](https://github.com/Nisugi/lich-5/commit/1da04062373d22ab76acce1129ee42aa0ce96a70))
* **dr:** DRCMM.moon_weapon_duration - read a moon weapon's remaining life ([#1483](https://github.com/Nisugi/lich-5/issues/1483)) ([88b0ba3](https://github.com/Nisugi/lich-5/commit/88b0ba3a16c50c851e3e97ca0ead44966d50b89d))
* **dr:** DRCS allow custom adjective for summoned weapons ([#1088](https://github.com/Nisugi/lich-5/issues/1088)) ([2790d8c](https://github.com/Nisugi/lich-5/commit/2790d8c2dbc1001306d0f3711af2ae5e5800feb2))
* **dr:** DRExpMonitor move into core lich ([#1154](https://github.com/Nisugi/lich-5/issues/1154)) ([48524b9](https://github.com/Nisugi/lich-5/commit/48524b9a1bef7089f371df5bb0073792ef287023))
* **dr:** DRParser support for new exp window xml stream elements (rested exp, tdps, favors) ([#1104](https://github.com/Nisugi/lich-5/issues/1104)) ([ba6a1cf](https://github.com/Nisugi/lich-5/commit/ba6a1cf7ba2d45f496232290d25df4089bfd4be8))
* **dr:** id-based creature tracking from crtrStatus + assess ([#1485](https://github.com/Nisugi/lich-5/issues/1485)) ([5e1f9a5](https://github.com/Nisugi/lich-5/commit/5e1f9a5dc99e658a8d76526282ad7ce880e467f9))
* **dr:** Implement DRCA.need_buffs? method for buff checks ([#1428](https://github.com/Nisugi/lich-5/issues/1428)) ([7e4d9e1](https://github.com/Nisugi/lich-5/commit/7e4d9e1845fdfb1b6c7b4397844550732ea40ac5))
* **dr:** support meta:trashcan tag for DRCI.dispose_trash ([#966](https://github.com/Nisugi/lich-5/issues/966)) ([d6a08ed](https://github.com/Nisugi/lich-5/commit/d6a08ed730206750e9c978a5763476a842644874))
* **dr:** user-extensible boxes and trash receptacles (03 of 06) ([#1514](https://github.com/Nisugi/lich-5/issues/1514)) ([a0994b3](https://github.com/Nisugi/lich-5/commit/a0994b342a179665d39747009e6dd0bddaeba99a))
* **dr:** user-extensible flavor-text stripping (05 of 06) ([#1516](https://github.com/Nisugi/lich-5/issues/1516)) ([9936c5c](https://github.com/Nisugi/lich-5/commit/9936c5cf27768be523898f463a07bd11fae29ec1))
* **dr:** user-extensible scroll substitutions via settings (01 of 06) ([#1512](https://github.com/Nisugi/lich-5/issues/1512)) ([3ad0d97](https://github.com/Nisugi/lich-5/commit/3ad0d973b21c0722cdb3b1000392e8a643a7e644))
* **dr:** user-extensible summoned-weapon adjectives (04 of 06) ([#1515](https://github.com/Nisugi/lich-5/issues/1515)) ([0d3cb0e](https://github.com/Nisugi/lich-5/commit/0d3cb0ef336555b67c2a0c136e35ad921296ed4a))
* **dr:** xmlparser: add structured parser for the assess (combat situation) stream ([#1413](https://github.com/Nisugi/lich-5/issues/1413)) ([9fe9553](https://github.com/Nisugi/lich-5/commit/9fe9553d7720bcd941e0b9d1e267cf1b204c46d3))
* **gs:** Add Armaments (Weapon, Armor, and Shield) Module ([#911](https://github.com/Nisugi/lich-5/issues/911)) ([4dd3d40](https://github.com/Nisugi/lich-5/commit/4dd3d404e94d5da1a54267dc63d900a7d225cdb6))
* **gs:** add creature module, including Hinterwilds creatures ([#1002](https://github.com/Nisugi/lich-5/issues/1002)) ([ff65c1e](https://github.com/Nisugi/lich-5/commit/ff65c1eb744bd4a950ad1bb741b42c7261dbcc9c))
* **gs:** add creature template library ([#1427](https://github.com/Nisugi/lich-5/issues/1427)) ([fd8b5ef](https://github.com/Nisugi/lich-5/commit/fd8b5eff96f8ddee64a26c5d2610c731edc802f1))
* **gs:** add Enhancive module for enhancive item bonus tracking ([#1113](https://github.com/Nisugi/lich-5/issues/1113)) ([61cff8f](https://github.com/Nisugi/lich-5/commit/61cff8f7fb0155c6ebf8096186bed1cd8fc023e9))
* **gs:** add Injured class for checking ability to perform actions ([#1035](https://github.com/Nisugi/lich-5/issues/1035)) ([e97a74d](https://github.com/Nisugi/lich-5/commit/e97a74dac26c780b7d5fadff06e0064d79559b0d))
* **gs:** add QStrike module for optimal stamina-based RT reduction ([#1114](https://github.com/Nisugi/lich-5/issues/1114)) ([b10af81](https://github.com/Nisugi/lich-5/commit/b10af81f1ec8ad6143f58e1565968312d469a62e))
* **gs:** Breakout and Buildout Societes ([#919](https://github.com/Nisugi/lich-5/issues/919)) ([0964bbf](https://github.com/Nisugi/lich-5/commit/0964bbf0b0caf46374322bfa4b79137742942bac))
* **gs:** Creature module combat tracking ([#1003](https://github.com/Nisugi/lich-5/issues/1003)) ([452a34a](https://github.com/Nisugi/lich-5/commit/452a34ae90b944e993fa4fe147f3301481753529))
* **gs:** creature xml additions ([#1425](https://github.com/Nisugi/lich-5/issues/1425)) ([4889222](https://github.com/Nisugi/lich-5/commit/48892224a6e84f8ef73796c93dadc8b4c4d90d1a))
* **gs:** gameobj add full_name matcher to type/sellable classification ([#1453](https://github.com/Nisugi/lich-5/issues/1453)) ([0546bef](https://github.com/Nisugi/lich-5/commit/0546bef56d55e504f15220228ce173239d18df39))
* **gs:** Overwatch module into core ([#1201](https://github.com/Nisugi/lich-5/issues/1201)) ([70dee4b](https://github.com/Nisugi/lich-5/commit/70dee4bd617de4ee8c38ec8b585fc9a56fd100b5))
* **gs:** PSMS add support for FORCERT ([#890](https://github.com/Nisugi/lich-5/issues/890)) ([9e8cdbc](https://github.com/Nisugi/lich-5/commit/9e8cdbccef94bc4b526a661c1afbb954c75b2542))
* **gs:** ReadyList & StowList classes for item tracking ([#884](https://github.com/Nisugi/lich-5/issues/884)) ([ff1faa0](https://github.com/Nisugi/lich-5/commit/ff1faa00c194c04c7a99fdba9dc1ce18d89f9a10))
* **gs:** track time of last total_experience record ([#1030](https://github.com/Nisugi/lich-5/issues/1030)) ([e9b31b7](https://github.com/Nisugi/lich-5/commit/e9b31b7a5413a62a99aeaae4edcd700a6d8abe22))
* **main:** add --bind-address option to set listen socket address ([#1405](https://github.com/Nisugi/lich-5/issues/1405)) ([bc82338](https://github.com/Nisugi/lich-5/commit/bc82338abbd8cbf897476099feb3ee4a2f4b2970))


### Bug Fixes

* **all:** [lib][global-defs] - move update ([#1079](https://github.com/Nisugi/lich-5/issues/1079)) ([a5b69ae](https://github.com/Nisugi/lich-5/commit/a5b69aeefda773d8ff745978cbe5c62feaac79b2))
* **all:** account manager sorting GUI fix ([#1123](https://github.com/Nisugi/lich-5/issues/1123)) ([4457f4b](https://github.com/Nisugi/lich-5/commit/4457f4b2b509751a4dd25489f957c1fb0ecfecf4))
* **all:** add --gs and --dr, refactor argv_options to helpers ([#1133](https://github.com/Nisugi/lich-5/issues/1133)) ([a809a26](https://github.com/Nisugi/lich-5/commit/a809a26cb9694fa699855dd91de6888aa906c514))
* **all:** add retry with exponential backoff for all login authentication ([#1205](https://github.com/Nisugi/lich-5/issues/1205)) ([ff365ef](https://github.com/Nisugi/lich-5/commit/ff365ef783cdd6803ce01e811b6ecf2cb5937859))
* **all:** Add sqlite busy timeout policy to core ([#1365](https://github.com/Nisugi/lich-5/issues/1365)) ([c6bd57c](https://github.com/Nisugi/lich-5/commit/c6bd57c5a5ae630ef835febdbacf591790d6f843))
* **all:** add timeout safety to fput to prevent infinite hangs ([#1261](https://github.com/Nisugi/lich-5/issues/1261)) ([79176c3](https://github.com/Nisugi/lich-5/commit/79176c3b07c46fe4fed920ed70714bc23b4b3913))
* **all:** Add top-level parse_args/display_args bridge to global_defs ([#1346](https://github.com/Nisugi/lich-5/issues/1346)) ([cca6322](https://github.com/Nisugi/lich-5/commit/cca6322316b99d7b44bd97121d23e9d4e9adc24c))
* **all:** add window size / position saves to login GUI ([#1128](https://github.com/Nisugi/lich-5/issues/1128)) ([4a22a1e](https://github.com/Nisugi/lich-5/commit/4a22a1eb88a9a754af857711263d0174682e6ae9))
* **all:** addbacks and corrections for charsettings and gamesettings ([#889](https://github.com/Nisugi/lich-5/issues/889)) ([98c0765](https://github.com/Nisugi/lich-5/commit/98c076507ee17b2c2e4dfe9740b19b511b371ba6))
* **all:** address ActiveSessions lifecycle hot path feature-flag polling ([#1325](https://github.com/Nisugi/lich-5/issues/1325)) ([1accc54](https://github.com/Nisugi/lich-5/commit/1accc542fc64b0f86f24b5871a97b20e0968cb36))
* **all:** align --announce with --update for Ruby version ([#1447](https://github.com/Nisugi/lich-5/issues/1447)) ([e20803c](https://github.com/Nisugi/lich-5/commit/e20803c403678ddab7abef93170fb26cd29e89ae))
* **all:** allow --add-account to run without yaml and dat ([#1143](https://github.com/Nisugi/lich-5/issues/1143)) ([ca48153](https://github.com/Nisugi/lich-5/commit/ca48153f36c96d70728142d1e5621ed82b2e7750))
* **all:** Allow hmr to work on global_defs.rb ([#1156](https://github.com/Nisugi/lich-5/issues/1156)) ([b077c8a](https://github.com/Nisugi/lich-5/commit/b077c8a6fca3cd6059606a834014b3b25b6cb3a3))
* **all:** bound EAccess auth with a timeout so a stalled SGE backend can't hang Lich silently ([#1502](https://github.com/Nisugi/lich-5/issues/1502)) ([426878d](https://github.com/Nisugi/lich-5/commit/426878d126c40a7a289282365a000325b628f5ff))
* **all:** bound GemCheck alert dialogs with a timeout so they can't hang forever ([#1488](https://github.com/Nisugi/lich-5/issues/1488)) ([291bfca](https://github.com/Nisugi/lich-5/commit/291bfcac9a801efd28b8d0bb1d6a88c9b60d1031))
* **all:** bound long-session memory growth (index/hook/watchfor/buffer leaks) ([#1410](https://github.com/Nisugi/lich-5/issues/1410)) ([85090d4](https://github.com/Nisugi/lich-5/commit/85090d4df22cde3d2e8f662bb322315c6f8d2786))
* **all:** catch ECONNRESET in _puts and bound walk_to retry depth ([#1327](https://github.com/Nisugi/lich-5/issues/1327)) ([1362072](https://github.com/Nisugi/lich-5/commit/136207200fe3a1aca0543686d8d32a2ee486b1e7))
* **all:** change class to is_a? checks ([#913](https://github.com/Nisugi/lich-5/issues/913)) ([f6a441a](https://github.com/Nisugi/lich-5/commit/f6a441af56df867d52e9df0ed749164f39e8522c))
* **all:** change encodings in main.rb to wizard FE only ([#1199](https://github.com/Nisugi/lich-5/issues/1199)) ([fe43007](https://github.com/Nisugi/lich-5/commit/fe4300702392b8b4c1720ac3f988cc2fa56d2bf9))
* **all:** change Hash[] pair key conversion to use to_h for Ruby 4.0 ([#1108](https://github.com/Nisugi/lich-5/issues/1108)) ([3af9467](https://github.com/Nisugi/lich-5/commit/3af9467d3261ee172d31f4f4b8537f00e3be01fc))
* **all:** Change server_time_offset in XMLParser to be float instead of int ([#1184](https://github.com/Nisugi/lich-5/issues/1184)) ([2e26e8e](https://github.com/Nisugi/lich-5/commit/2e26e8ea7af4c8ccb208af19a806a9005e8d7526))
* **all:** compact client write queue instead of ending the session ([#1498](https://github.com/Nisugi/lich-5/issues/1498)) ([bd3413b](https://github.com/Nisugi/lich-5/commit/bd3413b787653a6d0e7c736cd263f77080cc8105))
* **all:** Coordinate script shutdown draining (03 of 06) ([#1476](https://github.com/Nisugi/lich-5/issues/1476)) ([0ce5bae](https://github.com/Nisugi/lich-5/commit/0ce5bae9807cced74ae76d62d05befffafba99ae))
* **all:** copy Gemfile and LICENSE during self-update ([#1345](https://github.com/Nisugi/lich-5/issues/1345)) ([9d56522](https://github.com/Nisugi/lich-5/commit/9d56522f12d96682bddd90f320cf1c1be00e18ca))
* **all:** correct path-flag aliases and document all path options ([#1472](https://github.com/Nisugi/lich-5/issues/1472)) ([db5e38d](https://github.com/Nisugi/lich-5/commit/db5e38d504e56d3425ed7ffdf05eb12b20c64028))
* **all:** correct RP timing issue for release notes ([#1348](https://github.com/Nisugi/lich-5/issues/1348)) ([b85f087](https://github.com/Nisugi/lich-5/commit/b85f0877a95abdb640ea048686fbe8ba19272b90))
* **all:** database_adapter.rb error handling improvement ([#956](https://github.com/Nisugi/lich-5/issues/956)) ([52f13d8](https://github.com/Nisugi/lich-5/commit/52f13d8f93cc9401c4df2860cde315679c486062))
* **all:** delegate .to_json properly in settings_proxy ([#927](https://github.com/Nisugi/lich-5/issues/927)) ([fa72e1d](https://github.com/Nisugi/lich-5/commit/fa72e1de7f50bf7dc810de096f95dff89417b742))
* **all:** enable --login for multi-variable custom launch commands ([#1144](https://github.com/Nisugi/lich-5/issues/1144)) ([0464b2d](https://github.com/Nisugi/lich-5/commit/0464b2d2e781a4aed1e1d8469bbd54689272ca62))
* **all:** enable heartbeat-driven failover for ActiveSessions service owner ([#1340](https://github.com/Nisugi/lich-5/issues/1340)) ([eb69403](https://github.com/Nisugi/lich-5/commit/eb694032c67b75a833f141b0c9fdb132a4b04031))
* **all:** enforce beta confirmation 10s timeout ([#1315](https://github.com/Nisugi/lich-5/issues/1315)) ([6ad4ebb](https://github.com/Nisugi/lich-5/commit/6ad4ebb1c2fcd2865d9573cd2d245f5119e44c6c))
* **all:** ensure proxy path is set for non-destructive array write-th… ([#1073](https://github.com/Nisugi/lich-5/issues/1073)) ([546fa6b](https://github.com/Nisugi/lich-5/commit/546fa6b9f54bdb0018c32a4e3f236f3fd577a870))
* **all:** ensure SessionLifecycle.stop runs on abnormal exit ([#1317](https://github.com/Nisugi/lich-5/issues/1317)) ([a835d19](https://github.com/Nisugi/lich-5/commit/a835d19c2ffdf08d607edad46a38b21886eab8d0))
* **all:** ensure updates do not target detached proxy views ([#990](https://github.com/Nisugi/lich-5/issues/990)) ([366f1ad](https://github.com/Nisugi/lich-5/commit/366f1ad97b8d975987631469cc88a7bedad912d7))
* **all:** Exit quickly on CLI authentication failure ([#1237](https://github.com/Nisugi/lich-5/issues/1237)) ([f177cd0](https://github.com/Nisugi/lich-5/commit/f177cd0f5434139767d0b3494a4640bf1d480a1d))
* **all:** extract game-agnostic CreatureBase into lib/common ([#1484](https://github.com/Nisugi/lich-5/issues/1484)) ([76f8052](https://github.com/Nisugi/lich-5/commit/76f8052276f55eee5e02dd0578fdf7392178365d))
* **all:** fix GameObj container initialization and add clear_all_containers ([#1226](https://github.com/Nisugi/lich-5/issues/1226)) ([2a9a6da](https://github.com/Nisugi/lich-5/commit/2a9a6daa6a9327e903e8f1dc59d0421b290970bd))
* **all:** fix multiple custom entries, improvements to yaml save ([#1134](https://github.com/Nisugi/lich-5/issues/1134)) ([86e69a3](https://github.com/Nisugi/lich-5/commit/86e69a353ca323cc922fc06abddca3b61f62c0ff))
* **all:** fix three revert bugs in SnapshotManager ([#1289](https://github.com/Nisugi/lich-5/issues/1289)) ([fa87aa0](https://github.com/Nisugi/lich-5/commit/fa87aa0e8a804343be329145ab147d8f738b886c))
* **all:** force system gem install if RubyGems fails ([#1126](https://github.com/Nisugi/lich-5/issues/1126)) ([4b43170](https://github.com/Nisugi/lich-5/commit/4b431701718143f339670924dd52599f9a9dea2c))
* **all:** GameObj force new objects ID to be string ([#1087](https://github.com/Nisugi/lich-5/issues/1087)) ([2c467b8](https://github.com/Nisugi/lich-5/commit/2c467b8b40a98cffc5609e8c056936ef2c681bb1))
* **all:** GameObj object dedupe & GC ([#1234](https://github.com/Nisugi/lich-5/issues/1234)) ([6a48812](https://github.com/Nisugi/lich-5/commit/6a4881280aa7f656aee103fdd92c37e72fd5dfe2))
* **all:** gameobj.rb deeper lookup ([#885](https://github.com/Nisugi/lich-5/issues/885)) ([190a74a](https://github.com/Nisugi/lich-5/commit/190a74a853305db480a18dd7edc85a92d74f253f))
* **all:** games.rb catch additional error for nested single/double qu… ([#1031](https://github.com/Nisugi/lich-5/issues/1031)) ([7e572cf](https://github.com/Nisugi/lich-5/commit/7e572cfbb8a8682d022ced5fd2ccce829be74518))
* **all:** games.rb correct detection of invalid attributes and clean ([#924](https://github.com/Nisugi/lich-5/issues/924)) ([27d856f](https://github.com/Nisugi/lich-5/commit/27d856f9210dedf21eb4dcaa9326439ad00b0cf5))
* **all:** gate object cleanup in GTK queue ([#1354](https://github.com/Nisugi/lich-5/issues/1354)) ([4828aca](https://github.com/Nisugi/lich-5/commit/4828acab5b2049467b4a266088dfdb2319ef0cb0))
* **all:** guard against broken pipe errors in Game._puts and send_to_client ([#1260](https://github.com/Nisugi/lich-5/issues/1260)) ([995cefd](https://github.com/Nisugi/lich-5/commit/995cefd3ade131c5a819e3a6f649f7a2e4f95470))
* **all:** guard nil release asset and validate before deleting lib/ ([#1290](https://github.com/Nisugi/lich-5/issues/1290)) ([b8e3002](https://github.com/Nisugi/lich-5/commit/b8e3002e206771b1a6937ddcdb1d630e01600b84))
* **all:** guard nil stable version in beta channel resolution ([#1291](https://github.com/Nisugi/lich-5/issues/1291)) ([c5c42c6](https://github.com/Nisugi/lich-5/commit/c5c42c6a5e5042a97aeb250a0c8e142259cb830a))
* **all:** gui_login prevent destroying window if already destroyed ([#1127](https://github.com/Nisugi/lich-5/issues/1127)) ([3dd8808](https://github.com/Nisugi/lich-5/commit/3dd880865cc3d9713ffda0e2f8a1218ca5833b7b))
* **all:** handle auth exceptions in manual login to prevent hang on bad password ([#1267](https://github.com/Nisugi/lich-5/issues/1267)) ([05dfe30](https://github.com/Nisugi/lich-5/commit/05dfe306dd9a2d64f54d97b0dc14511e00a8be03))
* **all:** harden custom repo identity, collision, and contract boundaries ([#1333](https://github.com/Nisugi/lich-5/issues/1333)) ([b3d5daf](https://github.com/Nisugi/lich-5/commit/b3d5daf3db2ac08d54237673c3ed0e59ba67c32b))
* **all:** harden detachable client teardown and escape init payload ([#1493](https://github.com/Nisugi/lich-5/issues/1493)) ([84ce0fb](https://github.com/Nisugi/lich-5/commit/84ce0fb3be7bc1c772c0089be5d2396bfff75af5))
* **all:** harden FeatureFlags for closed db handle ([#1335](https://github.com/Nisugi/lich-5/issues/1335)) ([8195b73](https://github.com/Nisugi/lich-5/commit/8195b737f55d6ca5d6436d591c6b1efe8fad1ee9))
* **all:** Harden script lifecycle ownership (05 of 06) ([#1478](https://github.com/Nisugi/lich-5/issues/1478)) ([ec448f1](https://github.com/Nisugi/lich-5/commit/ec448f1d2e29f94f21d6772b4072551a50e33def))
* **all:** Honor Simu-side teardown for 10 seconds ([#1505](https://github.com/Nisugi/lich-5/issues/1505)) ([5b27c71](https://github.com/Nisugi/lich-5/commit/5b27c717d3260bb5e48b30c862aa7686aa2b0e89))
* **all:** identify Genie as the frontend for headless launches ([#1490](https://github.com/Nisugi/lich-5/issues/1490)) ([67e853e](https://github.com/Nisugi/lich-5/commit/67e853e44037167a539ddb0daf4b1fd2e74d4b9d))
* **all:** improve and harden shutdown ([#1416](https://github.com/Nisugi/lich-5/issues/1416)) ([3b7d377](https://github.com/Nisugi/lich-5/commit/3b7d3777d369e03e7ca46a87ec652e98583f41a8))
* **all:** improve MacOS keychain system check for older OS variants ([#1310](https://github.com/Nisugi/lich-5/issues/1310)) ([2423bf2](https://github.com/Nisugi/lich-5/commit/2423bf23c23584842a804d16ffb278f64125b501))
* **all:** Improve shutdown session state handling ([#1359](https://github.com/Nisugi/lich-5/issues/1359)) ([db8cf8f](https://github.com/Nisugi/lich-5/commit/db8cf8f07f8a9fe7949b47b42b04d5eac7c9e9d3))
* **all:** increase read timeout on idle socket to 300 seconds ([#1426](https://github.com/Nisugi/lich-5/issues/1426)) ([cbb06ad](https://github.com/Nisugi/lich-5/commit/cbb06ade6e8d0d552e7b6dab61ff5063965528d5))
* **all:** install_gem_requirements update available gems after install ([#1120](https://github.com/Nisugi/lich-5/issues/1120)) ([782b00b](https://github.com/Nisugi/lich-5/commit/782b00bcabb014558340fd006df16d4dea765742))
* **all:** limitedarray.rb max_size increase ([#946](https://github.com/Nisugi/lich-5/issues/946)) ([19d585a](https://github.com/Nisugi/lich-5/commit/19d585a013f8840a3419be4ab0ed7e7d9a698ff0))
* **all:** limitedarray.rb max_size increase [#946](https://github.com/Nisugi/lich-5/issues/946) ([46cb3fa](https://github.com/Nisugi/lich-5/commit/46cb3faf4b1621197e7ec48dd72491cf293e61a3))
* **all:** Linux WINE and Wrayth FE detection ([#1517](https://github.com/Nisugi/lich-5/issues/1517)) ([c735c32](https://github.com/Nisugi/lich-5/commit/c735c327f1a2648dc1546e5c0f2d5220e1207b3f))
* **all:** log and re-raise unexpected errors in saved login auth handler ([#1271](https://github.com/Nisugi/lich-5/issues/1271)) ([5ea9501](https://github.com/Nisugi/lich-5/commit/5ea950199d83ddc97fb5aa241d70e42a71c9d0bd))
* **all:** login_tab_utils.rb expand helper text show Warlock ([#1135](https://github.com/Nisugi/lich-5/issues/1135)) ([1b43e0d](https://github.com/Nisugi/lich-5/commit/1b43e0d12b5afa88207ac017b03d790519c260d3))
* **all:** map dijkstra optimization ([#1061](https://github.com/Nisugi/lich-5/issues/1061)) ([782df48](https://github.com/Nisugi/lich-5/commit/782df481960e0dea30d392144f044a14a0d4c249))
* **all:** map_base.rb sort JSON better ([#1171](https://github.com/Nisugi/lich-5/issues/1171)) ([7e60e68](https://github.com/Nisugi/lich-5/commit/7e60e68c1dc310ebe87a10cbf25696287cf7f4bc))
* **all:** Mapdb sort tags by downcase and original case ([#1433](https://github.com/Nisugi/lich-5/issues/1433)) ([7621993](https://github.com/Nisugi/lich-5/commit/76219936385014262c532cbd4c413342629078e5))
* **all:** messaging debug not compared to falseclass ([#887](https://github.com/Nisugi/lich-5/issues/887)) ([c81ce28](https://github.com/Nisugi/lich-5/commit/c81ce28e4b54d0e506a67177df6abf1c5bded047))
* **all:** messaging.rb encoding issue ([#933](https://github.com/Nisugi/lich-5/issues/933)) ([5069581](https://github.com/Nisugi/lich-5/commit/5069581bd0029456b1473627c1876ec7c9ec4386))
* **all:** messaging.rb return "" for xml_encode with Wizard ([#1147](https://github.com/Nisugi/lich-5/issues/1147)) ([96a5a7f](https://github.com/Nisugi/lich-5/commit/96a5a7f17b2f6d57ec456a2fcf798bf8c76a2a7c))
* **all:** minimum Ruby 4.0 required & migrate Ruby version check ([#1444](https://github.com/Nisugi/lich-5/issues/1444)) ([0372f6b](https://github.com/Nisugi/lich-5/commit/0372f6b83f561903fdd3a93609511568fac506c6))
* **all:** monkeypatch gi for memoryreleaser / asyncprocessor until patched upstream ([#1429](https://github.com/Nisugi/lich-5/issues/1429)) ([56fe509](https://github.com/Nisugi/lich-5/commit/56fe509119338a1bcb46e6e655956eda8c053636))
* **all:** move gui-login.rb to Ruby standard gui_login.rb ([#1111](https://github.com/Nisugi/lich-5/issues/1111)) ([47abb8f](https://github.com/Nisugi/lich-5/commit/47abb8ff8817d2e4f1528647af0b1020cfee21c3))
* **all:** Mutli-launch persistent login GUI ([#1245](https://github.com/Nisugi/lich-5/issues/1245)) ([3e4a873](https://github.com/Nisugi/lich-5/commit/3e4a873131311e57da32f029ccb2a9e70bc5211d))
* **all:** narrow safe_write rollback scope so cleanup failure preserves successful write ([#1287](https://github.com/Nisugi/lich-5/issues/1287)) ([8974813](https://github.com/Nisugi/lich-5/commit/8974813089c3fd274a62dc049336792be89e7421))
* **all:** no-op Gtk.lich_main_quit when no main loop is nested ([#1464](https://github.com/Nisugi/lich-5/issues/1464)) ([0028738](https://github.com/Nisugi/lich-5/commit/00287384042030c316f33fb3d84e780addce2d04))
* **all:** non tabbed saved entries in reduced button / font size (not… ([#1129](https://github.com/Nisugi/lich-5/issues/1129)) ([2ec9f0b](https://github.com/Nisugi/lich-5/commit/2ec9f0b5b7e507df493657f98f1f1eeaf7e608cb))
* **all:** non-ascii hygeine to address rubocop errors ([#1360](https://github.com/Nisugi/lich-5/issues/1360)) ([a1dfea8](https://github.com/Nisugi/lich-5/commit/a1dfea84f1532e6a76eccb2c431f3d7336a566cd))
* **all:** password_cipher.rb upcase account_name for key ([#1118](https://github.com/Nisugi/lich-5/issues/1118)) ([e4d41dc](https://github.com/Nisugi/lich-5/commit/e4d41dc9e15d4bd0effd4b520d8a3dfc0479eb0d))
* **all:** Persistent Launcher re-enable play button post launch ([#1269](https://github.com/Nisugi/lich-5/issues/1269)) ([72d532f](https://github.com/Nisugi/lich-5/commit/72d532f43b0f12fd925ca75e2f7d9447a72508a1))
* **all:** pin lich directory for gemfile check ([#1423](https://github.com/Nisugi/lich-5/issues/1423)) ([9b7bad0](https://github.com/Nisugi/lich-5/commit/9b7bad0f9b502cf557786ed357888b6b4185d713))
* **all:** preserve bundled display-state tags on quiet-suppressed chunks ([#1530](https://github.com/Nisugi/lich-5/issues/1530)) ([28c8828](https://github.com/Nisugi/lich-5/commit/28c88288d0df05c8d2f663affc64df362c2da461))
* **all:** prevent closing connection on module reload ([#1148](https://github.com/Nisugi/lich-5/issues/1148)) ([2540a14](https://github.com/Nisugi/lich-5/commit/2540a1497fd301996be3e0d8466b1b065979b733))
* **all:** prevent empty/partial GameObj registry reads during mid-stream refresh ([#1370](https://github.com/Nisugi/lich-5/issues/1370)) ([e9c5eda](https://github.com/Nisugi/lich-5/commit/e9c5eda6df04305769f1ee85dace5aef361438db))
* **all:** prevent zombie server deadlock in Active Sessions accept loop ([#1302](https://github.com/Nisugi/lich-5/issues/1302)) ([8e32538](https://github.com/Nisugi/lich-5/commit/8e3253817f25d7a7e7f8433a3b5f348ded7557d1))
* **all:** Quit Gtk.main cleanly ([#1455](https://github.com/Nisugi/lich-5/issues/1455)) ([d25e152](https://github.com/Nisugi/lich-5/commit/d25e152c3ec737b3ed7d35cb11dc05aa9334563f))
* **all:** recover from cross-process zombie in ActiveSessions service ([#1355](https://github.com/Nisugi/lich-5/issues/1355)) ([17642a5](https://github.com/Nisugi/lich-5/commit/17642a52396e10dbc97b0a7d6fc022ebcf61db01))
* **all:** reduce minimum GUI window footprint for non-tabbed view ([#1138](https://github.com/Nisugi/lich-5/issues/1138)) ([79b18ed](https://github.com/Nisugi/lich-5/commit/79b18ed2d70d5ae56bd01477ec859acb4508e220))
* **all:** Refactor regex to string comparisons for ARGV options ([#1456](https://github.com/Nisugi/lich-5/issues/1456)) ([cec0f60](https://github.com/Nisugi/lich-5/commit/cec0f60e6489a2c1ffa259975b3d4b159de30dc9))
* **all:** remove dead code in BranchInstaller ([#1292](https://github.com/Nisugi/lich-5/issues/1292)) ([b3c480a](https://github.com/Nisugi/lich-5/commit/b3c480a18245ccb37060effd6e65597758e098b3))
* **all:** Remove debug log IO from heartbeat tick loop ([#1363](https://github.com/Nisugi/lich-5/issues/1363)) ([475cefa](https://github.com/Nisugi/lich-5/commit/475cefaeef3c2b3c97b32d9fab826261f1bb5ddd))
* **all:** remove double save in YAML to preserve yaml.bak integrity ([#1139](https://github.com/Nisugi/lich-5/issues/1139)) ([0c26110](https://github.com/Nisugi/lich-5/commit/0c2611081c37a4167a5a729d7da1b1b34e5aa96f))
* **all:** remove password parameter from debug logging in all cases ([#1137](https://github.com/Nisugi/lich-5/issues/1137)) ([fe21beb](https://github.com/Nisugi/lich-5/commit/fe21beb7bdd8ddaa8b7c7ec6254165587bbc2162))
* **all:** remove strip! from settingsInfo replacement ([#1161](https://github.com/Nisugi/lich-5/issues/1161)) ([aef52ad](https://github.com/Nisugi/lich-5/commit/aef52add62c47daa73579ac69e13db0352c34cdd))
* **all:** Remove Windows OS CMD prompt flash ([#1255](https://github.com/Nisugi/lich-5/issues/1255)) ([26b7581](https://github.com/Nisugi/lich-5/commit/26b7581394d48d821e235c33050b274bf2d246ec))
* **all:** reorder shutdown ala MahtraDR and detect script teardown de… ([#1369](https://github.com/Nisugi/lich-5/issues/1369)) ([5831d98](https://github.com/Nisugi/lich-5/commit/5831d98fd60f0c1308547152d6ded0fd8ce436ff))
* **all:** repair regression on gui button reenable from refactor ([#1297](https://github.com/Nisugi/lich-5/issues/1297)) ([f10b1f9](https://github.com/Nisugi/lich-5/commit/f10b1f95f4c1f0720505d5823e43f334b3c12d62))
* **all:** resilient ActiveSessions ownership + shutdown watchdog ([#1452](https://github.com/Nisugi/lich-5/issues/1452)) ([1eaa043](https://github.com/Nisugi/lich-5/commit/1eaa043f19a13d61ea963336edd6388d2957c223))
* **all:** resolve GameObj status visibility during staged  refresh ([#1497](https://github.com/Nisugi/lich-5/issues/1497)) ([1b7067d](https://github.com/Nisugi/lich-5/commit/1b7067da15287bc8f24d354f3edc89d9036a6653))
* **all:** restore detachable client disconnect notice to stdout ([#1492](https://github.com/Nisugi/lich-5/issues/1492)) ([13b9142](https://github.com/Nisugi/lich-5/commit/13b9142e870dd205f6d988720fb4b8ca5132dad6))
* **all:** Restore manual login behaviors to not require saved entry t… ([#1270](https://github.com/Nisugi/lich-5/issues/1270)) ([5eb6d4f](https://github.com/Nisugi/lich-5/commit/5eb6d4f3c492a6a9961a55a785100eed06ec965a))
* **all:** restore Wrayth / Wizard script execution ability ([#952](https://github.com/Nisugi/lich-5/issues/952)) ([6b7149c](https://github.com/Nisugi/lich-5/commit/6b7149c2afea112a6a1079e3440294b2e3fcb7bc))
* **all:** rubocop custom cop ascii only cleanup ([#1382](https://github.com/Nisugi/lich-5/issues/1382)) ([eab6757](https://github.com/Nisugi/lich-5/commit/eab6757ffcefc876938738390a8534fc8d2bf836))
* **all:** safeguard gtk logo.png loading ([#1329](https://github.com/Nisugi/lich-5/issues/1329)) ([f15237a](https://github.com/Nisugi/lich-5/commit/f15237a9fdf31aa9c595f45e9492357a36360bd8))
* **all:** Script module replace MemoryReleaser with GC.start for cleanup ([#1364](https://github.com/Nisugi/lich-5/issues/1364)) ([9a89d26](https://github.com/Nisugi/lich-5/commit/9a89d26a2e3a08ce032a251b4b7a2ed1e5274919))
* **all:** script.rb show custom at script exit as well ([#993](https://github.com/Nisugi/lich-5/issues/993)) ([dfe92dd](https://github.com/Nisugi/lich-5/commit/dfe92ddbc8a20a4b51e98c048bdd81379ff4e425))
* **all:** script.rb show Script.kill source ([#1235](https://github.com/Nisugi/lich-5/issues/1235)) ([fbbf04c](https://github.com/Nisugi/lich-5/commit/fbbf04cf02cdbb3cabda3f163d6094c6bcd78d36))
* **all:** Script#kill remove GC.start and add optional instrumentation ([#1368](https://github.com/Nisugi/lich-5/issues/1368)) ([0233e4b](https://github.com/Nisugi/lich-5/commit/0233e4b30c769ffd6978159a6700f6b60dec1c72))
* **all:** scrub startup credentials once login completes ([#1499](https://github.com/Nisugi/lich-5/issues/1499)) ([1805df4](https://github.com/Nisugi/lich-5/commit/1805df4e09cdaa40d8aada11b56cecc9acc4206c))
* **all:** set SO_REUSEADDR before bind to allow immediate port reuse ([#1268](https://github.com/Nisugi/lich-5/issues/1268)) ([9db4b6b](https://github.com/Nisugi/lich-5/commit/9db4b6be4882b300bf5531e7020aa2808d9d13ab))
* **all:** settings_proxy implement to_h for appropriate behaviors ([#896](https://github.com/Nisugi/lich-5/issues/896)) ([b24c6d1](https://github.com/Nisugi/lich-5/commit/b24c6d1a11bacdb8209e36f76d2598a57efcbe97))
* **all:** settings.rb update to preserve root of derived views ([#975](https://github.com/Nisugi/lich-5/issues/975)) ([09b3a5b](https://github.com/Nisugi/lich-5/commit/09b3a5b88cbe85d066ed57616df93a9aff17a18e))
* **all:** Show CLI login ARGV for SAL connections ([#1424](https://github.com/Nisugi/lich-5/issues/1424)) ([071e285](https://github.com/Nisugi/lich-5/commit/071e285b9131fd8937129860ff609cfe492d7a49))
* **all:** show custom in various script output when custom script ([#967](https://github.com/Nisugi/lich-5/issues/967)) ([236e202](https://github.com/Nisugi/lich-5/commit/236e202c9413d2e2e4782418c64fc3dbf4b3b4b9))
* **all:** stop locking the load path at boot; keep Gemfile.lock in sync on self-update ([#1434](https://github.com/Nisugi/lich-5/issues/1434)) ([d3da0eb](https://github.com/Nisugi/lich-5/commit/d3da0ebb3b0a86a897f0b8c03f88f926661ec1c3))
* **all:** stop SessionLifecycle before closing database on normal exit ([#1334](https://github.com/Nisugi/lich-5/issues/1334)) ([2f0517f](https://github.com/Nisugi/lich-5/commit/2f0517f269d642e149faf6b95c69bf3d2b0a4739))
* **all:** stringproc normalize CRLF | CR to LF ([#1378](https://github.com/Nisugi/lich-5/issues/1378)) ([04bd9ec](https://github.com/Nisugi/lich-5/commit/04bd9ec519eedd784f56fbc75191e1d4e3382220))
* **all:** stub sync_all_repos to prevent leaked thread in games_spec ([#1311](https://github.com/Nisugi/lich-5/issues/1311)) ([fa0d252](https://github.com/Nisugi/lich-5/commit/fa0d25219002e581abbd3d89dd310dfd5e8d9ac4))
* **all:** suppress wine detection noise and skip when unneeded ([#1244](https://github.com/Nisugi/lich-5/issues/1244)) ([dfcd813](https://github.com/Nisugi/lich-5/commit/dfcd81395d7a827d088654579e810924a28c283a))
* **all:** surface the underlying LoadError in dependency alerts ([#1480](https://github.com/Nisugi/lich-5/issues/1480)) ([1fc7fc8](https://github.com/Nisugi/lich-5/commit/1fc7fc8723eacdc6097df72aff2946d510af45ef))
* **all:** Synchronize script lifecycle transitions (02 of 06) ([#1475](https://github.com/Nisugi/lich-5/issues/1475)) ([a6ff9a1](https://github.com/Nisugi/lich-5/commit/a6ff9a149e3615734d8703f4b0ce944d1e903de6))
* **all:** SynchronizedSocket write resilience and zombie client elimination ([#1338](https://github.com/Nisugi/lich-5/issues/1338)) ([9c38b4d](https://github.com/Nisugi/lich-5/commit/9c38b4d845c652098745cb99ef8bd4e26f06c1ce))
* **all:** terminate preserved quiet-state tags with a  newline ([#1532](https://github.com/Nisugi/lich-5/issues/1532)) ([be68052](https://github.com/Nisugi/lich-5/commit/be68052b8a39c280f1998a3e56233c34e83dab01))
* **all:** update CLI for YAML security signature, add auto-convert fo… ([#1136](https://github.com/Nisugi/lich-5/issues/1136)) ([b1c690a](https://github.com/Nisugi/lich-5/commit/b1c690af39b2ac045b8413a3f83b57defa264b70))
* **all:** update Gemstone game-code validations ([#1518](https://github.com/Nisugi/lich-5/issues/1518)) ([49f2d7f](https://github.com/Nisugi/lich-5/commit/49f2d7f33226970508fd4247b798f68bfdb65c5d))
* **all:** update location for currency and move game-loader.rb to Ruby standard gameloader.rb ([#1112](https://github.com/Nisugi/lich-5/issues/1112)) ([39bbb60](https://github.com/Nisugi/lich-5/commit/39bbb6094f16380d1e4ecd6c080d6199faef170d))
* **all:** Update module strip markdown comments ([#1056](https://github.com/Nisugi/lich-5/issues/1056)) ([44693ba](https://github.com/Nisugi/lich-5/commit/44693ba017a076ca65d572d86dd0fca47076c659))
* **all:** update.rb allow for bugfix betas and branch updates ([#1211](https://github.com/Nisugi/lich-5/issues/1211)) ([2d60245](https://github.com/Nisugi/lich-5/commit/2d602450d38c19724b09fa9527776a49a642f907))
* **all:** update.rb keep script/data file incase of error on update ([#1070](https://github.com/Nisugi/lich-5/issues/1070)) ([2f09881](https://github.com/Nisugi/lich-5/commit/2f09881dd7df27c84abb07c1daff6fbdab04d087))
* **all:** update.rb pervent update if MIN_RUBY not met ([#1146](https://github.com/Nisugi/lich-5/issues/1146)) ([24b5173](https://github.com/Nisugi/lich-5/commit/24b5173a55400f4fff78d7f3677a85912de239cf))
* **all:** update.rb word boundary for abbreviations ([#971](https://github.com/Nisugi/lich-5/issues/971)) ([bdd065e](https://github.com/Nisugi/lich-5/commit/bdd065e9cc5e80d922a760f2aaa080701c8d4bb7))
* **all:** update.rb word boundary for abbreviations [#971](https://github.com/Nisugi/lich-5/issues/971) ([cab86e8](https://github.com/Nisugi/lich-5/commit/cab86e81fd2156faa7875d805eaf99f8bfec8ebf))
* **all:** Updated update.rb for single trunk and release please ([#1001](https://github.com/Nisugi/lich-5/issues/1001)) ([7840b3d](https://github.com/Nisugi/lich-5/commit/7840b3d7d4e3e19a1c6bb226fb614f737471a41c))
* **all:** use :__unset for --without-frontend CLI request YAML matches ([#1301](https://github.com/Nisugi/lich-5/issues/1301)) ([b0b84d8](https://github.com/Nisugi/lich-5/commit/b0b84d82a3527cef744e8138b6d1367ca6838806))
* **all:** use bundler to check for required Ruby gems ([#1420](https://github.com/Nisugi/lich-5/issues/1420)) ([7b98d2c](https://github.com/Nisugi/lich-5/commit/7b98d2c5cc762e6c3a8c2a5adaeae47e4a2fbe29))
* **all:** use send(:respond) in StatusReporter fallback path ([#1316](https://github.com/Nisugi/lich-5/issues/1316)) ([7b56363](https://github.com/Nisugi/lich-5/commit/7b563634750f1a617b64f0c47e4ab792645cc6a1))
* **all:** uservars.rb update for vars method missing ([#940](https://github.com/Nisugi/lich-5/issues/940)) ([5f94c07](https://github.com/Nisugi/lich-5/commit/5f94c07bb67a1c322157b8ad43dd9f38ff1f441f))
* **all:** Util.issue_command allow single line captures ([#918](https://github.com/Nisugi/lich-5/issues/918)) ([7e5a09f](https://github.com/Nisugi/lich-5/commit/7e5a09fefa564dce448f9b57aac1c42ff6bfe8f8))
* **all:** util.rb only show gem installing debug messaging if gem mis… ([#1131](https://github.com/Nisugi/lich-5/issues/1131)) ([dd55334](https://github.com/Nisugi/lich-5/commit/dd55334351715dda9feea214ed91bf59563ef754))
* **all:** Vars/UserVars module fixes and corrections ([#1057](https://github.com/Nisugi/lich-5/issues/1057)) ([7338ef1](https://github.com/Nisugi/lich-5/commit/7338ef189ac03289daeb72fddb3ae7a22a2ed4ba))
* **all:** xmlparser.rb gate GSL exits sending behind [@send](https://github.com/send)_fake_tags ([#1103](https://github.com/Nisugi/lich-5/issues/1103)) ([053319d](https://github.com/Nisugi/lich-5/commit/053319d883c0c3dec0ccebf2978c19f9dc7ba3b1))
* **dr:** add 'You scoop' match pattern to common-items ([#900](https://github.com/Nisugi/lich-5/issues/900)) ([3860523](https://github.com/Nisugi/lich-5/commit/38605235d291b701e5f992c4604728bc77ae82cc))
* **dr:** add bounded recursion depth limits to 9 methods ([#1257](https://github.com/Nisugi/lich-5/issues/1257)) ([fea0776](https://github.com/Nisugi/lich-5/commit/fea0776172c0aa64e8cf0bf0c47fed407478ee00))
* **dr:** add bput match for system updates preventing actions ([#1034](https://github.com/Nisugi/lich-5/issues/1034)) ([5df10f1](https://github.com/Nisugi/lich-5/commit/5df10f1f8d75598bfea52caf2467e9bad92f7041))
* **dr:** add buffering for multiline room players ([#1151](https://github.com/Nisugi/lich-5/issues/1151)) ([c7c2cc7](https://github.com/Nisugi/lich-5/commit/c7c2cc78459e01b1507f0469dbca43eb631bc0de))
* **dr:** Add CORE_AUTOSTART sentinel to skip dependency.lic autostart helpers ([#1344](https://github.com/Nisugi/lich-5/issues/1344)) ([c5db210](https://github.com/Nisugi/lich-5/commit/c5db2103a39cd8ffc19ddd837fd6e34fb6f09ed7))
* **dr:** add missing match patterns ([#901](https://github.com/Nisugi/lich-5/issues/901)) ([dbafdda](https://github.com/Nisugi/lich-5/commit/dbafdda5548ee152c337a02799de861e6bab2ff5))
* **dr:** Add missing matches for common-items ([#905](https://github.com/Nisugi/lich-5/issues/905)) ([522abe2](https://github.com/Nisugi/lich-5/commit/522abe2c7088579ed08143eaa1335c544284824a))
* **dr:** add verify_script def here instead of depending on dependency ([#1155](https://github.com/Nisugi/lich-5/issues/1155)) ([21560de](https://github.com/Nisugi/lich-5/commit/21560de0c7ccebb3cd1c6259c78de3eea7e801b4))
* **dr:** anchor stow success pattern to prevent fan close recovery bypass ([#1254](https://github.com/Nisugi/lich-5/issues/1254)) ([c96933d](https://github.com/Nisugi/lich-5/commit/c96933dee8f15be6409530592a42b021c8bcf259))
* **dr:** BalanceValue regex to match combat status lines ([#1398](https://github.com/Nisugi/lich-5/issues/1398)) ([7f2448c](https://github.com/Nisugi/lich-5/commit/7f2448cf756892f14a85aa3fd9f1ad0a08197718)), closes [#1394](https://github.com/Nisugi/lich-5/issues/1394)
* **dr:** buffer split room obj lines and merge instead of appending closing tag to broken line ([#1149](https://github.com/Nisugi/lich-5/issues/1149)) ([b8dd4a2](https://github.com/Nisugi/lich-5/commit/b8dd4a2f3d25f45d89843eb58624db4e07f246d6))
* **dr:** buffer_room_objs missed split components with leading stream tags ([#1284](https://github.com/Nisugi/lich-5/issues/1284)) ([e858d91](https://github.com/Nisugi/lich-5/commit/e858d91746075d1c5b713826e9683ef5710c3f73))
* **dr:** cache SlackBot users list to prevent API throttling ([#1342](https://github.com/Nisugi/lich-5/issues/1342)) ([dd7a0c7](https://github.com/Nisugi/lich-5/commit/dd7a0c702351f7033912ac4c4d88b86426cdcfb3))
* **dr:** change keys for DR_SKILLS_DATA[:guild_skill_aliases] to be strings instead of symbols ([#1032](https://github.com/Nisugi/lich-5/issues/1032)) ([1fc7510](https://github.com/Nisugi/lich-5/commit/1fc75105ea378b204503dd0538bcd153ccff2f38))
* **dr:** common-arcana.rb Regalia fix for changed game output. ([#970](https://github.com/Nisugi/lich-5/issues/970)) ([5d1b126](https://github.com/Nisugi/lich-5/commit/5d1b12672b961f8200969f3d29743ce2c75acd8a))
* **dr:** common-arcana.rb Regalia fix for changed game output. [#970](https://github.com/Nisugi/lich-5/issues/970) ([cab86e8](https://github.com/Nisugi/lich-5/commit/cab86e81fd2156faa7875d805eaf99f8bfec8ebf))
* **dr:** common-healing.rb -  DRCH.bind_wound: only dispose a dislodged item while it is in hand ([#1469](https://github.com/Nisugi/lich-5/issues/1469)) ([422d5a7](https://github.com/Nisugi/lich-5/commit/422d5a7843b2128269cfe20dd941a794b4c1a702))
* **dr:** common-items: add and fix match strings ([#904](https://github.com/Nisugi/lich-5/issues/904)) ([a554c48](https://github.com/Nisugi/lich-5/commit/a554c4861aa458e3ec87a5d3a042afcae289bd29))
* **dr:** common-items.rb - get_item_unsafe false positives via XML feed verification ([#1286](https://github.com/Nisugi/lich-5/issues/1286)) ([b3c286f](https://github.com/Nisugi/lich-5/commit/b3c286f38442007098ab3038dcfbf804f9fb57c0))
* **dr:** common-items.rb - move pattern from failure to success block ([#1262](https://github.com/Nisugi/lich-5/issues/1262)) ([7209d3a](https://github.com/Nisugi/lich-5/commit/7209d3add9a908c3f377b16fb207b49b3f783a7d))
* **dr:** common-items.rb Fix for changed inventory command output ([#973](https://github.com/Nisugi/lich-5/issues/973)) ([fcec3c4](https://github.com/Nisugi/lich-5/commit/fcec3c44ae21ef0afd0b26ed6b3f0408dcdd1534))
* **dr:** common-items.rb Fix for changed inventory command output [#973](https://github.com/Nisugi/lich-5/issues/973) ([cab86e8](https://github.com/Nisugi/lich-5/commit/cab86e81fd2156faa7875d805eaf99f8bfec8ebf))
* **dr:** common-items.rb wear/remove messaging additions ([#949](https://github.com/Nisugi/lich-5/issues/949)) ([5b3e651](https://github.com/Nisugi/lich-5/commit/5b3e651201c130d25582c5f16a88492f80a80e86))
* **dr:** correct fix_standing infinite loop when standing is impossible ([#3668](https://github.com/Nisugi/lich-5/issues/3668)) ([#1441](https://github.com/Nisugi/lich-5/issues/1441)) ([29c3e22](https://github.com/Nisugi/lich-5/commit/29c3e220e5d0dff3447173777be739bb361a6e9d))
* **dr:** DR modules fixes and enhancements ([#1232](https://github.com/Nisugi/lich-5/issues/1232)) ([4c63805](https://github.com/Nisugi/lich-5/commit/4c63805bb3f5aca6c059d9b3922ce8b85b8fe60d))
* **dr:** DRC text2num correction for thousand ([#1343](https://github.com/Nisugi/lich-5/issues/1343)) ([ee3528e](https://github.com/Nisugi/lich-5/commit/ee3528e3a8fb1224795b66d7ba22c95addb49da5))
* **dr:** DRCA allow custom spell prep messaging ([#1089](https://github.com/Nisugi/lich-5/issues/1089)) ([42f5025](https://github.com/Nisugi/lich-5/commit/42f502575a7a45abcad76aab41b2ef133712e586))
* **dr:** drdefs.rb npc parsing ([#1038](https://github.com/Nisugi/lich-5/issues/1038)) ([328c2b2](https://github.com/Nisugi/lich-5/commit/328c2b29fd8f7d8efb017a55086ded77d30ac4b9))
* **dr:** drparser.rb to set ShowRoomID to on if turned off ([#945](https://github.com/Nisugi/lich-5/issues/945)) ([7365317](https://github.com/Nisugi/lich-5/commit/7365317fafc0c0aec52c16dc887694e61e826ae2))
* **dr:** drparser.rb update for Platinum account status ([#922](https://github.com/Nisugi/lich-5/issues/922)) ([460f07f](https://github.com/Nisugi/lich-5/commit/460f07f8f9d17f9f165a2208fd3da541aafe9df5))
* **dr:** drparser.rb update for PlayedSubscription ([#983](https://github.com/Nisugi/lich-5/issues/983)) ([49508d7](https://github.com/Nisugi/lich-5/commit/49508d78a5a492a78e53b722835476f7186f68b6))
* **dr:** equipmanager update to assume missing items aren't worn ([#1376](https://github.com/Nisugi/lich-5/issues/1376)) ([4e32548](https://github.com/Nisugi/lich-5/commit/4e325486b253566eee67588498b22e25e13cbcb9))
* **dr:** equipmanager.rb - Fix unload weapon detection when AimTimerDialog tag is prepended ([#1414](https://github.com/Nisugi/lich-5/issues/1414)) ([d18c667](https://github.com/Nisugi/lich-5/commit/d18c6675d38a4165e4fddd76ea4f562507123cc2))
* **dr:** equipmanager.rb - reliable ranged-weapon transitions - stow ammo after unload + verify offhand wield hand ([#1468](https://github.com/Nisugi/lich-5/issues/1468)) ([a1555c0](https://github.com/Nisugi/lich-5/commit/a1555c026e7c03a41201ab23fcfaf502cc05a27d))
* **dr:** equipmanager.rb Fix for changed game output. ([#969](https://github.com/Nisugi/lich-5/issues/969)) ([f6d9d66](https://github.com/Nisugi/lich-5/commit/f6d9d66f83176b791575fce836702ceddf39ad4f))
* **dr:** equipmanager.rb Fix for changed game output. [#969](https://github.com/Nisugi/lich-5/issues/969) ([cab86e8](https://github.com/Nisugi/lich-5/commit/cab86e81fd2156faa7875d805eaf99f8bfec8ebf))
* **dr:** equipmanager.rb support for custom messaging in forester's longbow ([#1105](https://github.com/Nisugi/lich-5/issues/1105)) ([557fab5](https://github.com/Nisugi/lich-5/commit/557fab5f02e49008cce3ad71b1c4bb2d2eaa169a))
* **dr:** Fix container reference in get_item_from_eddy_portal method ([#1039](https://github.com/Nisugi/lich-5/issues/1039)) ([20a3f09](https://github.com/Nisugi/lich-5/commit/20a3f093925616d8ebd133e04847ae1eea817692))
* **dr:** Fix exp mods parsing for DR ([#1102](https://github.com/Nisugi/lich-5/issues/1102)) ([dbb50ed](https://github.com/Nisugi/lich-5/commit/dbb50ed6bff5aa7e3f46e44ed08d660cee09591a))
* **dr:** Fix hang in equipment manager when game doesn't respond to commands ([#1110](https://github.com/Nisugi/lich-5/issues/1110)) ([34c394a](https://github.com/Nisugi/lich-5/commit/34c394abbe04baa8cf1546e6005d5fb81280a90f))
* **dr:** Fix race condition when clearing and repopulating XMLData.dr_active_spells ([#907](https://github.com/Nisugi/lich-5/issues/907)) ([58b34da](https://github.com/Nisugi/lich-5/commit/58b34dadc25eb3388f7a28d884d4db53eab71db3))
* **dr:** Fix SLS release pattern ([#908](https://github.com/Nisugi/lich-5/issues/908)) ([746d15b](https://github.com/Nisugi/lich-5/commit/746d15baee726d6e9afd3eb58de56d781a1a5dcf))
* **dr:** forward vitality and dead fields in perceive_health ([#1288](https://github.com/Nisugi/lich-5/issues/1288)) ([cad008c](https://github.com/Nisugi/lich-5/commit/cad008c24736fce9370f1807f5d1a71c5ff8e688))
* **dr:** games.rb - ignore UIDs for Frostbite mapping ([#951](https://github.com/Nisugi/lich-5/issues/951)) ([d839d9e](https://github.com/Nisugi/lich-5/commit/d839d9ea075634ca59205c626d6c096b91bdda4f))
* **dr:** logbook_item recovery when crafted item not in hand ([#1175](https://github.com/Nisugi/lich-5/issues/1175)) ([da18fa9](https://github.com/Nisugi/lich-5/commit/da18fa95e602fdae0ee1cc256212fed4eaaba00d))
* **dr:** make $safe_pause_lock holder immune to pause ([#1525](https://github.com/Nisugi/lich-5/issues/1525)) ([517da01](https://github.com/Nisugi/lich-5/commit/517da016a0ad03eb8a57ab3566b9bd47711f2d20))
* **dr:** map_dr.rb prevent inadvertent settings changes ([#958](https://github.com/Nisugi/lich-5/issues/958)) ([e499253](https://github.com/Nisugi/lich-5/commit/e499253b325d76b3d786e9c5fe51173ade0034f0))
* **dr:** match (prone)/(sitting) posture detection under HidePostStrings ([#4529](https://github.com/Nisugi/lich-5/issues/4529)) ([#1442](https://github.com/Nisugi/lich-5/issues/1442)) ([3a1e824](https://github.com/Nisugi/lich-5/commit/3a1e824cd8820babe2eca9e7f6c4fbf5d44e2ab4))
* **dr:** preserve game RealID in room title (GS parity for ";display roomid title") ([#1500](https://github.com/Nisugi/lich-5/issues/1500)) ([11e9837](https://github.com/Nisugi/lich-5/commit/11e983770251079bef72587c57c3c58e6961b75b))
* **dr:** reduce symbol-torn scale scrolls to gettable noun ([#1506](https://github.com/Nisugi/lich-5/issues/1506)) ([5230576](https://github.com/Nisugi/lich-5/commit/5230576d542818f50411d09d425e8ffd651838cc))
* **dr:** Refine need_buffs? logic for non-recast spells to correctly check cyclic spells. ([#1503](https://github.com/Nisugi/lich-5/issues/1503)) ([011c372](https://github.com/Nisugi/lich-5/commit/011c372c9c75f01d647a0815681517d68f8c214f))
* **dr:** Release Khri Vanish if Thief, when going visible ([#906](https://github.com/Nisugi/lich-5/issues/906)) ([e13d21e](https://github.com/Nisugi/lich-5/commit/e13d21eee4f82ca09dd081c4ec4776d9b662386c))
* **dr:** replace undefined custom_require in check_moonwatch ([#1336](https://github.com/Nisugi/lich-5/issues/1336)) ([70df672](https://github.com/Nisugi/lich-5/commit/70df672f4ea0ed979238d950e92219ca99e67fde))
* **dr:** resolve no-UID rooms carrying a stored UID instead of returning nil ([#1467](https://github.com/Nisugi/lich-5/issues/1467)) ([4ba59f3](https://github.com/Nisugi/lich-5/commit/4ba59f399ffd906bb5200a285cc73f476bcfbab1))
* **dr:** resolve race condition in DR crafting_magic_routine ([#914](https://github.com/Nisugi/lich-5/issues/914)) ([722a71e](https://github.com/Nisugi/lich-5/commit/722a71ea6b4045b6b9c036da322539b3a9297452))
* **dr:** set_stance places 100 in the correct positional slot ([#1337](https://github.com/Nisugi/lich-5/issues/1337)) ([2a1ac51](https://github.com/Nisugi/lich-5/commit/2a1ac518615a9246a1c18bf7befd20af28a57b8b))
* **dr:** stow_helper failure detection + unload_weapon ammo recovery ([#1259](https://github.com/Nisugi/lich-5/issues/1259)) ([d010383](https://github.com/Nisugi/lich-5/commit/d0103835bf18f595440ef22743ee0164254ae373))
* **dr:** Tighten checks on releasing invisibility for thieves ([#936](https://github.com/Nisugi/lich-5/issues/936)) ([0b15ceb](https://github.com/Nisugi/lich-5/commit/0b15cebb3f90da9e412dcd965eeb89bbe15ddaca))
* **dr:** Update regex and parsing for active spells ([#894](https://github.com/Nisugi/lich-5/issues/894)) ([6fe631f](https://github.com/Nisugi/lich-5/commit/6fe631f51756be03c0e0dd559f1cd0e78933c985))
* **dr:** Update Slackbot error handling, and lnet management ([#1091](https://github.com/Nisugi/lich-5/issues/1091)) ([f729c69](https://github.com/Nisugi/lich-5/commit/f729c690fb1221b0e39ff6ed309a8e6c5427751a))
* **dr:** validator.rb change sleep to should_sleep named param ([#1116](https://github.com/Nisugi/lich-5/issues/1116)) ([58e9168](https://github.com/Nisugi/lich-5/commit/58e9168bde5c36f91f683a5e7cb305320cc7fc05))
* **dr:** xmlparser.rb - Clear out spells properly ([#916](https://github.com/Nisugi/lich-5/issues/916)) ([8c929af](https://github.com/Nisugi/lich-5/commit/8c929afae1f84a8c9d6541ec89c52c708d8cd59c))
* **dr:** xmlparser.rb - Fix XMLData.dr_active_spells race condition ([#915](https://github.com/Nisugi/lich-5/issues/915)) ([617344b](https://github.com/Nisugi/lich-5/commit/617344ba2585b30f166e3ca949392e2e712136aa))
* **gs:** activespell.rb prevent removal of RF Penalty ([#981](https://github.com/Nisugi/lich-5/issues/981)) ([e1d5652](https://github.com/Nisugi/lich-5/commit/e1d5652a4866fb454d7cea6f263810398b966d5c))
* **gs:** add .compact to input of Disk.find_by_name ([#982](https://github.com/Nisugi/lich-5/issues/982)) ([f03ed8d](https://github.com/Nisugi/lich-5/commit/f03ed8d8dff292d041a70a0fa411a62083130984))
* **gs:** add base stats capture from 'info full' command ([#1115](https://github.com/Nisugi/lich-5/issues/1115)) ([1086093](https://github.com/Nisugi/lich-5/commit/1086093608914555f664f0eea462c3881ab2419e))
* **gs:** Add InnCheckedOut pattern to parser ([#1309](https://github.com/Nisugi/lich-5/issues/1309)) ([2aca7e1](https://github.com/Nisugi/lich-5/commit/2aca7e1c529ab317ece77e700ae92ab3345b76d4))
* **gs:** add support for RESERVE xml in GameObj.reserve ([#1341](https://github.com/Nisugi/lich-5/issues/1341)) ([f95a728](https://github.com/Nisugi/lich-5/commit/f95a728f2538c1f90703b63a5e87e6f7243b6765))
* **gs:** allow spell.rb casting to take a force_stance parameter ([#902](https://github.com/Nisugi/lich-5/issues/902)) ([f09b778](https://github.com/Nisugi/lich-5/commit/f09b7789114fd79b3f864d77d59825c17b4a4f82))
* **gs:** Bounty heirloom return msg'ing update ([#972](https://github.com/Nisugi/lich-5/issues/972)) ([73ac7e3](https://github.com/Nisugi/lich-5/commit/73ac7e3b6a3cb2a637ca4dc45d09f0cbd4a257d3))
* **gs:** bounty location regex needs to match "under" ([#1037](https://github.com/Nisugi/lich-5/issues/1037)) ([6358ba3](https://github.com/Nisugi/lich-5/commit/6358ba305e8c9cd5acb8f0340069f2812e7cc648))
* **gs:** bounty parser and move fixes for sailor's grief ([#987](https://github.com/Nisugi/lich-5/issues/987)) ([1faf6f4](https://github.com/Nisugi/lich-5/commit/1faf6f45765d9ebe19d35e8acad2e94be97f0bc6))
* **gs:** Bounty parser fix regex pattern for skin retrieval task ([#1242](https://github.com/Nisugi/lich-5/issues/1242)) ([d480143](https://github.com/Nisugi/lich-5/commit/d4801435018b6f988ab5db4b3d74318f11668205))
* **gs:** Bounty parser for SG npcs matching ([#1027](https://github.com/Nisugi/lich-5/issues/1027)) ([f4e993f](https://github.com/Nisugi/lich-5/commit/f4e993f6299b595d0dd713939cc4093daa0c87a4))
* **gs:** Bounty parser.rb FWI guard regex update ([#1096](https://github.com/Nisugi/lich-5/issues/1096)) ([036a2c5](https://github.com/Nisugi/lich-5/commit/036a2c5d1090e9806deb4c1181abcdfba6ed591e))
* **gs:** change namespace accessors to Ruby 2.6 compatible ([#944](https://github.com/Nisugi/lich-5/issues/944)) ([a7bf292](https://github.com/Nisugi/lich-5/commit/a7bf29279384acdf53fd7ced0a8c9cd59c6de7ba))
* **gs:** Claim corrections to handle mounts in room_players stream ([#1324](https://github.com/Nisugi/lich-5/issues/1324)) ([ea08107](https://github.com/Nisugi/lich-5/commit/ea0810701a7adcadc4ac2073e053790a627512b5))
* **gs:** cman.rb add hamstring regex for already lying down target ([#1090](https://github.com/Nisugi/lich-5/issues/1090)) ([79e2b91](https://github.com/Nisugi/lich-5/commit/79e2b91a9932ea10c916fca126d0d1a67ba9f6b8))
* **gs:** cman.rb hamstring regex update when can't perform on target ([#1092](https://github.com/Nisugi/lich-5/issues/1092)) ([966aa78](https://github.com/Nisugi/lich-5/commit/966aa78bd33ba8af9a3744e13e46fa6b113f4917))
* **gs:** combat module hardening - ordered processing, 22x faster parsing, double-count fix ([#1523](https://github.com/Nisugi/lich-5/issues/1523)) ([6d8474a](https://github.com/Nisugi/lich-5/commit/6d8474a610aa54f0bcfb0fdcd151232c44913db2))
* **gs:** critranks.rb tolerate nil table rows, fix reload!, index patterns … ([#1522](https://github.com/Nisugi/lich-5/issues/1522)) ([e707ba5](https://github.com/Nisugi/lich-5/commit/e707ba57ccdaded293b0b4a4948caeb925a069dd))
* **gs:** Currency add method to retrieve aevit event currency ([#1411](https://github.com/Nisugi/lich-5/issues/1411)) ([53669a5](https://github.com/Nisugi/lich-5/commit/53669a56d7549ee19f0c58228cc019352d348f75))
* **gs:** currency.rb track gold ([#1109](https://github.com/Nisugi/lich-5/issues/1109)) ([f51c351](https://github.com/Nisugi/lich-5/commit/f51c35145d7289964f437b084652ab7110222042))
* **gs:** Feat excoriate regex correction ([#920](https://github.com/Nisugi/lich-5/issues/920)) ([9b994a5](https://github.com/Nisugi/lich-5/commit/9b994a5453f2849c8353d7515e4de18951473f23))
* **gs:** force PROFILE FULL to sync CHE info for infomon ([#937](https://github.com/Nisugi/lich-5/issues/937)) ([fc3982c](https://github.com/Nisugi/lich-5/commit/fc3982c5814d1888a4deb0bfa0ceaacbfcbd15b8))
* **gs:** GameObj targets for new Sailor's Grief tentacle npc ([#948](https://github.com/Nisugi/lich-5/issues/948)) ([dad133d](https://github.com/Nisugi/lich-5/commit/dad133d57cbf89a9e0148b9bc94849dd0b1d53a8))
* **gs:** gameobj.rb for Sailor's Grief ghostly/boss/guild tentacles ([#989](https://github.com/Nisugi/lich-5/issues/989)) ([38d022d](https://github.com/Nisugi/lich-5/commit/38d022d76aa73167ac287a2caacb7e1b0b574ff9))
* **gs:** global_defs move() update regex for standing condition ([#1407](https://github.com/Nisugi/lich-5/issues/1407)) ([2e172b2](https://github.com/Nisugi/lich-5/commit/2e172b28004b116487223fa335af7594a0047102))
* **gs:** global_defs update pushStream regex to include 'reserve' id ([#1379](https://github.com/Nisugi/lich-5/issues/1379)) ([cc76d50](https://github.com/Nisugi/lich-5/commit/cc76d50b0e39fc1227bac3794b848d72fc20e564))
* **gs:** global_defs.rb move def update for Hive traps ([#980](https://github.com/Nisugi/lich-5/issues/980)) ([036367e](https://github.com/Nisugi/lich-5/commit/036367ed54b39b1e1b58b66d32bffe43b25b7705))
* **gs:** include store location for ReadyList ([#977](https://github.com/Nisugi/lich-5/issues/977)) ([fd8d1a9](https://github.com/Nisugi/lich-5/commit/fd8d1a9adef01840c93ba5c7d0e94388a990a443))
* **gs:** Infomon additional CHE resign regex ([#1067](https://github.com/Nisugi/lich-5/issues/1067)) ([94108ef](https://github.com/Nisugi/lich-5/commit/94108ef5ecb19ea86eafd711d6fb33ef5f3f2f15))
* **gs:** Infomon parse fix for singular currency ([#1051](https://github.com/Nisugi/lich-5/issues/1051)) ([eea0ea3](https://github.com/Nisugi/lich-5/commit/eea0ea3e45dcfeb85a19721fdd39eb85862125c1))
* **gs:** Infomon parser.rb bug in EnhanciveEnd ([#1198](https://github.com/Nisugi/lich-5/issues/1198)) ([fe20c7b](https://github.com/Nisugi/lich-5/commit/fe20c7b069157f4e244f19d376a117fa0c6f11a0))
* **gs:** infomon parser.rb for profile full name matching ([#938](https://github.com/Nisugi/lich-5/issues/938)) ([5d2735d](https://github.com/Nisugi/lich-5/commit/5d2735d87d23bddcb88a138beab26d9425f306f5))
* **gs:** Infomon parser.rb update Account.subscription/type ([#1192](https://github.com/Nisugi/lich-5/issues/1192)) ([698d1da](https://github.com/Nisugi/lich-5/commit/698d1daf7da2d50fa330f84f4f60180e7ec21033))
* **gs:** infomon parser.rb update for ACCOUNT output varies ([#979](https://github.com/Nisugi/lich-5/issues/979)) ([a741e18](https://github.com/Nisugi/lich-5/commit/a741e18b5cb438cb846392c9c29f6106edff2a2d))
* **gs:** infomon state reset on status prompt ([#943](https://github.com/Nisugi/lich-5/issues/943)) ([d6acb8a](https://github.com/Nisugi/lich-5/commit/d6acb8a534dca4735e593fcf2193c2cf5d6ae72f))
* **gs:** Infomon Status.cutthroat? Effect Debuff correction ([#1331](https://github.com/Nisugi/lich-5/issues/1331)) ([1af00de](https://github.com/Nisugi/lich-5/commit/1af00deec063841cae04857fda0b6e11dcbc456c))
* **gs:** Infomon xmlparser additional npc death messaging ([#1275](https://github.com/Nisugi/lich-5/issues/1275)) ([517f7cf](https://github.com/Nisugi/lich-5/commit/517f7cfa77d86cc44e2bcb40cf7f6e4bf39700f3))
* **gs:** Infomon xmlparser additional npc death messaging ([#1281](https://github.com/Nisugi/lich-5/issues/1281)) ([d66dc50](https://github.com/Nisugi/lich-5/commit/d66dc50b76712147c7ec082c1476e64f0f46d620))
* **gs:** Infomon xmlparser additional npc death messaging ([#1326](https://github.com/Nisugi/lich-5/issues/1326)) ([940894a](https://github.com/Nisugi/lich-5/commit/940894a4c88f3f2b09e539237ed8372052c47d21))
* **gs:** Infomon xmlparser.rb Ready/Stow fix for LONG before exist ([#988](https://github.com/Nisugi/lich-5/issues/988)) ([a75df76](https://github.com/Nisugi/lich-5/commit/a75df76ee18a03ba9580189476541ca07b5eff58))
* **gs:** infomon.rb added updated_at field to upsert_batch ([#1145](https://github.com/Nisugi/lich-5/issues/1145)) ([ff2b4b5](https://github.com/Nisugi/lich-5/commit/ff2b4b551e4f9438c9a28c74fd98ed1c15c6a9e2))
* **gs:** infomon.rb bug in _key transformation ([#1216](https://github.com/Nisugi/lich-5/issues/1216)) ([46bfc81](https://github.com/Nisugi/lich-5/commit/46bfc811d41bb3d0d80911b9e64b6fb6ca13186b))
* **gs:** ingest newly-exposed mindState experience and roommeta room fields ([#1450](https://github.com/Nisugi/lich-5/issues/1450)) ([3339e7d](https://github.com/Nisugi/lich-5/commit/3339e7d5aebded21685b50121cec37f6d08fba5d))
* **gs:** map_gs.rb remove `delete_if` to prevent bad settings ([#957](https://github.com/Nisugi/lich-5/issues/957)) ([56f8d53](https://github.com/Nisugi/lich-5/commit/56f8d53afb227dc50dac67a78678775014bf8330))
* **gs:** match READY/STOW items with a/an/some inside the link ([#1026](https://github.com/Nisugi/lich-5/issues/1026)) ([e57561a](https://github.com/Nisugi/lich-5/commit/e57561a611d1d07c974e4255b461be60c09d98fd))
* **gs:** Overwatch add REVEALED_EXPLODES regex pattern ([#1356](https://github.com/Nisugi/lich-5/issues/1356)) ([9a14b70](https://github.com/Nisugi/lich-5/commit/9a14b7052c2f4ea9d4f58e03e575b9be9537a9b9))
* **gs:** PSMS cost for multiple cost types & add Excoriate feat ([#912](https://github.com/Nisugi/lich-5/issues/912)) ([231e582](https://github.com/Nisugi/lich-5/commit/231e5820c4ebb9f715878f5b479c5274edf127e2))
* **gs:** PSMS fetch lookup use long_name after normalization ([#899](https://github.com/Nisugi/lich-5/issues/899)) ([2ba9f26](https://github.com/Nisugi/lich-5/commit/2ba9f26d174735e5e72f4011991efe8c85dee0ef))
* **gs:** psms Warcry.available? correction ([#1387](https://github.com/Nisugi/lich-5/issues/1387)) ([8414658](https://github.com/Nisugi/lich-5/commit/84146585c8de01af97ca97bd9a966c6af379edb4))
* **gs:** psms.rb add additional failure matches ([#1238](https://github.com/Nisugi/lich-5/issues/1238)) ([4ce94d2](https://github.com/Nisugi/lich-5/commit/4ce94d247132a9c26dd4285f30e048ee3702e769))
* **gs:** readylist.rb check method fix when dead ([#1153](https://github.com/Nisugi/lich-5/issues/1153)) ([29729f4](https://github.com/Nisugi/lich-5/commit/29729f45fa731af2a74d21bc48daa45fd0988f48))
* **gs:** readylist.rb wait for RT when issuing check ([#965](https://github.com/Nisugi/lich-5/issues/965)) ([48da96b](https://github.com/Nisugi/lich-5/commit/48da96ba0e372ada253f51da6ea58c10fc6c1c22))
* **gs:** Resource tracking for sorcerer shadow essence ([#1085](https://github.com/Nisugi/lich-5/issues/1085)) ([7730550](https://github.com/Nisugi/lich-5/commit/7730550fd05b6e403d6fe0bf3c23dd68dc093d88))
* **gs:** Societies to check membership for various methods ([#942](https://github.com/Nisugi/lich-5/issues/942)) ([94800fd](https://github.com/Nisugi/lich-5/commit/94800fd866563b93883d443805591581b430d5b8))
* **gs:** spell.rb add last_cast to track last time casted ([#1193](https://github.com/Nisugi/lich-5/issues/1193)) ([67115dd](https://github.com/Nisugi/lich-5/commit/67115dd0b6bfbedc118de0740dc61f57603740a0))
* **gs:** standardize warcry.rb to match other PSMS ([#941](https://github.com/Nisugi/lich-5/issues/941)) ([0758dae](https://github.com/Nisugi/lich-5/commit/0758dae3a9439483bdb93bcd8b401355b1f13645))
* **gs:** Stash add_to_bag result type check before regex compare ([#1357](https://github.com/Nisugi/lich-5/issues/1357)) ([a6c1061](https://github.com/Nisugi/lich-5/commit/a6c1061167ed97f1ee0a458b0972665ac8940589))
* **gs:** Stash check result type before comparing regex for wear_to_inv ([#1430](https://github.com/Nisugi/lich-5/issues/1430)) ([96c0bda](https://github.com/Nisugi/lich-5/commit/96c0bda57ee73228dd538fc0fa5e09929276b98a))
* **gs:** stash.rb additional improvements ([#1132](https://github.com/Nisugi/lich-5/issues/1132)) ([8a8d906](https://github.com/Nisugi/lich-5/commit/8a8d906a4da56e2719789e0679e70bb88bae45b4))
* **gs:** stash.rb additional improvements with ReadyList/StowList ([#1197](https://github.com/Nisugi/lich-5/issues/1197)) ([5ef1c85](https://github.com/Nisugi/lich-5/commit/5ef1c859f188f506af2c7b29faa2b7b344035e21))
* **gs:** stash.rb ReadyList sheath handling and update inventory checks ([#1166](https://github.com/Nisugi/lich-5/issues/1166)) ([7aeec90](https://github.com/Nisugi/lich-5/commit/7aeec90f8faf8a4cef881317ab7719d6858c7b78))
* **gs:** StowList missing space in capture in xmlparser.rb ([#963](https://github.com/Nisugi/lich-5/issues/963)) ([88a880a](https://github.com/Nisugi/lich-5/commit/88a880a193173106a99d667efdba43b7a5d8498d))
* **gs:** StowList missing space in capture in xmlparser.rb [#963](https://github.com/Nisugi/lich-5/issues/963) ([cab86e8](https://github.com/Nisugi/lich-5/commit/cab86e81fd2156faa7875d805eaf99f8bfec8ebf))
* **gs:** stowlist.rb check method fix when dead ([#1152](https://github.com/Nisugi/lich-5/issues/1152)) ([ddf3a12](https://github.com/Nisugi/lich-5/commit/ddf3a12472ab026ab8fb74e1610a3bb50f38c220))
* **gs:** stowlist.rb wait for RT when issuing check ([#964](https://github.com/Nisugi/lich-5/issues/964)) ([ca38c70](https://github.com/Nisugi/lich-5/commit/ca38c708ed30ba530f222fdb05ddc00b85d632ce))
* **gs:** StowList/ReadyList reset bug if non-default keys added ([#1019](https://github.com/Nisugi/lich-5/issues/1019)) ([c97d86d](https://github.com/Nisugi/lich-5/commit/c97d86d65664e5defc252f7687fe6d918c54b4c7))
* **gs:** update Infomon parsing for new ACCOUNT output format ([#903](https://github.com/Nisugi/lich-5/issues/903)) ([ed25d30](https://github.com/Nisugi/lich-5/commit/ed25d30c5053b1fbac4133229162b1726abd635b))
* **gs:** Various CMan cost corrections ([#932](https://github.com/Nisugi/lich-5/issues/932)) ([d0f37cc](https://github.com/Nisugi/lich-5/commit/d0f37ccd02133daa145639420869d69e462634fe))
* **gs:** weapon PSM affordable check against Glorious Momentum ([#926](https://github.com/Nisugi/lich-5/issues/926)) ([246d60b](https://github.com/Nisugi/lich-5/commit/246d60bed6a1acdd1e8804729efc07605f1dd1cf))
* **gs:** weapon.rb assault break if no targets ([#962](https://github.com/Nisugi/lich-5/issues/962)) ([fa0ee6d](https://github.com/Nisugi/lich-5/commit/fa0ee6d2c9047128281db5445da84fb29b47e564))
* **gs:** xmlparser support new field exp, climate, terrain XML feeds ([#1388](https://github.com/Nisugi/lich-5/issues/1388)) ([97d0474](https://github.com/Nisugi/lich-5/commit/97d0474a8b371dd3171e1a4b3beb9db7ed0502fb))
* **gs:** xmlparser.rb capture additional death messaging ([#1158](https://github.com/Nisugi/lich-5/issues/1158)) ([02293d1](https://github.com/Nisugi/lich-5/commit/02293d1ce3b771a02b7a37176158b0ec4e09c766))
* **main:** surface a failed Game.open in the connect timeout ([#1408](https://github.com/Nisugi/lich-5/issues/1408)) ([c3a79fc](https://github.com/Nisugi/lich-5/commit/c3a79fc281c0faabb7094fddb4dc94da7582ae59))


### Performance

* **all:** enumerate script subdirs with file glob ([#1397](https://github.com/Nisugi/lich-5/issues/1397)) ([1a88720](https://github.com/Nisugi/lich-5/commit/1a8872032cd93646d735742ea871c819ff5d92d2))
* **all:** migrate the server-stream parser from REXML to Ox, with pipe-mode benchmark harness and DR parser coverage ([#1396](https://github.com/Nisugi/lich-5/issues/1396)) ([6366dc0](https://github.com/Nisugi/lich-5/commit/6366dc037a851e5c3e51b6f8867fe22cde1f8355))
* **gs:** anchor Infomon parser regex unions to line start ([#1391](https://github.com/Nisugi/lich-5/issues/1391)) ([7e04141](https://github.com/Nisugi/lich-5/commit/7e041411b2801e019c6b5d53f985bb507096f002))


### Refactoring

* **all:** Add frontend registry for capability-based configuration ([#1223](https://github.com/Nisugi/lich-5/issues/1223)) ([c1dcc19](https://github.com/Nisugi/lich-5/commit/c1dcc192233a02d131de19d9723e100876abb862))
* **all:** Centralize frontend capability checks in Frontend module ([#1170](https://github.com/Nisugi/lich-5/issues/1170)) ([26e4e00](https://github.com/Nisugi/lich-5/commit/26e4e003429a3577e4e025aed5917ceaba2bee58))
* **all:** CLI consolidation and --help cleanup ([#1314](https://github.com/Nisugi/lich-5/issues/1314)) ([ad2e9d8](https://github.com/Nisugi/lich-5/commit/ad2e9d8f0d3c8461c517fc235b4c49e16e3d16a3))
* **all:** Consolidate authentication code under lib/common/authentication ([#1240](https://github.com/Nisugi/lich-5/issues/1240)) ([14a2ce3](https://github.com/Nisugi/lich-5/commit/14a2ce3c59fbacdfc5e43793ea98a332b9de7430))
* **all:** Map update for robustness and maintainability ([#1163](https://github.com/Nisugi/lich-5/issues/1163)) ([b803822](https://github.com/Nisugi/lich-5/commit/b8038229e80b84c9d47577e8865b2970ce65e565))
* **all:** Refactor game initialization process ([#1162](https://github.com/Nisugi/lich-5/issues/1162)) ([b90bcf9](https://github.com/Nisugi/lich-5/commit/b90bcf97be6a404da1db6d238ad70aa7857ce958))
* **all:** reorganize specs to mirror lib/ and fix spec issues ([#1250](https://github.com/Nisugi/lich-5/issues/1250)) ([32ed5ac](https://github.com/Nisugi/lich-5/commit/32ed5ac4fa4c6bc425d240774bfa239957c33ee7))
* **all:** rework map lookup and indexing, drop legacy mapdb formats ([#1495](https://github.com/Nisugi/lich-5/issues/1495)) ([6d4cd14](https://github.com/Nisugi/lich-5/commit/6d4cd1499d278415f6f7fdcdd2ccbe425a2ca0c2))
* **all:** Unify script execution and library loading (04 of 06) ([#1477](https://github.com/Nisugi/lich-5/issues/1477)) ([9ed425a](https://github.com/Nisugi/lich-5/commit/9ed425a186ecdb2a6fd33acdfa7d91eefc0cf9f7))
* **dr:** Comprehensive DR modules refactor ([#1231](https://github.com/Nisugi/lich-5/issues/1231)) ([9bc7914](https://github.com/Nisugi/lich-5/commit/9bc79144d09bd27aed927044a19c0da575642eab))
* **dr:** consolidate DRCI/EquipmentManager patterns, YARD docs, bug fixes ([#1256](https://github.com/Nisugi/lich-5/issues/1256)) ([375b9a0](https://github.com/Nisugi/lich-5/commit/375b9a0a7640c370a0a437ce822843dbe67436df))
* **dr:** dragonrealms drinfomon audit - DRY/SOLID/robustness improvements ([#1243](https://github.com/Nisugi/lich-5/issues/1243)) ([0478671](https://github.com/Nisugi/lich-5/commit/04786718e8136394239193a2516f5979f83e539f))
* **dr:** DRY extraction of duplicated patterns in DRCI/EquipmentManager ([#1258](https://github.com/Nisugi/lich-5/issues/1258)) ([82e613b](https://github.com/Nisugi/lich-5/commit/82e613b44a8cd0ce39954299079f58b82b8178ff))
* **dr:** replace EquipmentManager verb_data hardcoded patterns with DRCI constants ([#1313](https://github.com/Nisugi/lich-5/issues/1313)) ([088e968](https://github.com/Nisugi/lich-5/commit/088e968a0d96404303dd3b7a07299b38e24ff0c3))
* **dr:** use yaml wire-brush-number in repair_own_tools ([#1241](https://github.com/Nisugi/lich-5/issues/1241)) ([931a579](https://github.com/Nisugi/lich-5/commit/931a579db0412f683577c927248db87baeb4819e))


### Documentation

* **all:** add DeepWiki auto-docs ([#1280](https://github.com/Nisugi/lich-5/issues/1280)) ([f9cbd45](https://github.com/Nisugi/lich-5/commit/f9cbd45bcbebe126078dde94f2518d6fc4840e51))
* **all:** add YARD documentation style guide and .yardopts ([#1252](https://github.com/Nisugi/lich-5/issues/1252)) ([5915eda](https://github.com/Nisugi/lich-5/commit/5915eda658141e17ce9a939d76ffeaa864c77ef2))
* **gs:** Group API YARD additions ([#1048](https://github.com/Nisugi/lich-5/issues/1048)) ([e4a611f](https://github.com/Nisugi/lich-5/commit/e4a611f137eb05b4c0a8394dc07563d5141ecc04))

## [5.20.1](https://github.com/elanthia-online/lich-5/compare/v5.20.0...v5.20.1) (2026-08-20)


### Bug Fixes

* **all:** bound EAccess auth with a timeout so a stalled SGE backend can't hang Lich silently ([#1502](https://github.com/elanthia-online/lich-5/issues/1502)) ([426878d](https://github.com/elanthia-online/lich-5/commit/426878d126c40a7a289282365a000325b628f5ff))
* **all:** Linux WINE and Wrayth FE detection ([#1517](https://github.com/elanthia-online/lich-5/issues/1517)) ([c735c32](https://github.com/elanthia-online/lich-5/commit/c735c327f1a2648dc1546e5c0f2d5220e1207b3f))
* **all:** preserve bundled display-state tags on quiet-suppressed chunks ([#1530](https://github.com/elanthia-online/lich-5/issues/1530)) ([28c8828](https://github.com/elanthia-online/lich-5/commit/28c88288d0df05c8d2f663affc64df362c2da461))
* **all:** update Gemstone game-code validations ([#1518](https://github.com/elanthia-online/lich-5/issues/1518)) ([49f2d7f](https://github.com/elanthia-online/lich-5/commit/49f2d7f33226970508fd4247b798f68bfdb65c5d))
* **all:** prevent a stray formatting character from appearing in Saga during quiet script output ([1532](https://github.com/elanthia-online/lich-5/pull/1532)) ([be68052](https://github.com/elanthia-online/lich-5/commit/be68052b8a39c280f1998a3e56233c34e83dab01))
* **dr:** make $safe_pause_lock holder immune to pause ([#1525](https://github.com/elanthia-online/lich-5/issues/1525)) ([517da01](https://github.com/elanthia-online/lich-5/commit/517da016a0ad03eb8a57ab3566b9bd47711f2d20))
* **gs:** combat module hardening - ordered processing, 22x faster parsing, double-count fix ([#1523](https://github.com/elanthia-online/lich-5/issues/1523)) ([6d8474a](https://github.com/elanthia-online/lich-5/commit/6d8474a610aa54f0bcfb0fdcd151232c44913db2))
* **gs:** critranks.rb tolerate nil table rows, fix reload!, index patterns … ([#1522](https://github.com/elanthia-online/lich-5/issues/1522)) ([e707ba5](https://github.com/elanthia-online/lich-5/commit/e707ba57ccdaded293b0b4a4948caeb925a069dd))

## [5.20.0](https://github.com/elanthia-online/lich-5/compare/v5.19.1...v5.20.0) (2026-08-12)


### Features

* **all:** --bind-address speaks the same keywords as --detachable-client ([#1461](https://github.com/elanthia-online/lich-5/issues/1461)) ([48e2296](https://github.com/elanthia-online/lich-5/commit/48e229664b923be97b866c44d182bd10e920066e))
* **all:** add concurrent runtime I/O and multi-client detach support ([#1459](https://github.com/elanthia-online/lich-5/issues/1459)) ([44cb27e](https://github.com/elanthia-online/lich-5/commit/44cb27ed15f4aaa0135de0ce19c389e3ab996bf0))
* **all:** Add forced script teardown command (06 of 06) ([#1479](https://github.com/elanthia-online/lich-5/issues/1479)) ([8f0772d](https://github.com/elanthia-online/lich-5/commit/8f0772dcdac73a7218f60989b342aec025e8f41b))
* **all:** Add supervised child script APIs (01 of 06) ([#1474](https://github.com/elanthia-online/lich-5/issues/1474)) ([6259b25](https://github.com/elanthia-online/lich-5/commit/6259b25114b3068ee970bd62fa867f4fb3f67d43))
* **all:** GUI Launcher Improvements ([#1463](https://github.com/elanthia-online/lich-5/issues/1463)) ([0d209c7](https://github.com/elanthia-online/lich-5/commit/0d209c7ef67aeb45281c576a0ff41a61cc39f7f5))
* **all:** teardown and distinguishable errors for Script.run_child ([#1501](https://github.com/elanthia-online/lich-5/issues/1501)) ([65ace54](https://github.com/elanthia-online/lich-5/commit/65ace5488cb014a8b014416f2d6b96665d5e4e3e))
* **dr:** capture room UID from &lt;nav&gt; tag; stop enforcing ShowRoomID; opt-in room-id placement ([#1491](https://github.com/elanthia-online/lich-5/issues/1491)) ([e5c852b](https://github.com/elanthia-online/lich-5/commit/e5c852b07fde40334142fc2dc45dbf023273e8a9))
* **dr:** DRCMM.moon_weapon_duration - read a moon weapon's remaining life ([#1483](https://github.com/elanthia-online/lich-5/issues/1483)) ([88b0ba3](https://github.com/elanthia-online/lich-5/commit/88b0ba3a16c50c851e3e97ca0ead44966d50b89d))
* **dr:** id-based creature tracking from crtrStatus + assess ([#1485](https://github.com/elanthia-online/lich-5/issues/1485)) ([5e1f9a5](https://github.com/elanthia-online/lich-5/commit/5e1f9a5dc99e658a8d76526282ad7ce880e467f9))
* **dr:** user-extensible boxes and trash receptacles (03 of 06) ([#1514](https://github.com/elanthia-online/lich-5/issues/1514)) ([a0994b3](https://github.com/elanthia-online/lich-5/commit/a0994b342a179665d39747009e6dd0bddaeba99a))
* **dr:** user-extensible flavor-text stripping (05 of 06) ([#1516](https://github.com/elanthia-online/lich-5/issues/1516)) ([9936c5c](https://github.com/elanthia-online/lich-5/commit/9936c5cf27768be523898f463a07bd11fae29ec1))
* **dr:** user-extensible scroll substitutions via settings (01 of 06) ([#1512](https://github.com/elanthia-online/lich-5/issues/1512)) ([3ad0d97](https://github.com/elanthia-online/lich-5/commit/3ad0d973b21c0722cdb3b1000392e8a643a7e644))
* **dr:** user-extensible summoned-weapon adjectives (04 of 06) ([#1515](https://github.com/elanthia-online/lich-5/issues/1515)) ([0d3cb0e](https://github.com/elanthia-online/lich-5/commit/0d3cb0ef336555b67c2a0c136e35ad921296ed4a))
* **gs:** gameobj add full_name matcher to type/sellable classification ([#1453](https://github.com/elanthia-online/lich-5/issues/1453)) ([0546bef](https://github.com/elanthia-online/lich-5/commit/0546bef56d55e504f15220228ce173239d18df39))


### Bug Fixes

* **all:** bound GemCheck alert dialogs with a timeout so they can't hang forever ([#1488](https://github.com/elanthia-online/lich-5/issues/1488)) ([291bfca](https://github.com/elanthia-online/lich-5/commit/291bfcac9a801efd28b8d0bb1d6a88c9b60d1031))
* **all:** compact client write queue instead of ending the session ([#1498](https://github.com/elanthia-online/lich-5/issues/1498)) ([bd3413b](https://github.com/elanthia-online/lich-5/commit/bd3413b787653a6d0e7c736cd263f77080cc8105))
* **all:** Coordinate script shutdown draining (03 of 06) ([#1476](https://github.com/elanthia-online/lich-5/issues/1476)) ([0ce5bae](https://github.com/elanthia-online/lich-5/commit/0ce5bae9807cced74ae76d62d05befffafba99ae))
* **all:** correct path-flag aliases and document all path options ([#1472](https://github.com/elanthia-online/lich-5/issues/1472)) ([db5e38d](https://github.com/elanthia-online/lich-5/commit/db5e38d504e56d3425ed7ffdf05eb12b20c64028))
* **all:** extract game-agnostic CreatureBase into lib/common ([#1484](https://github.com/elanthia-online/lich-5/issues/1484)) ([76f8052](https://github.com/elanthia-online/lich-5/commit/76f8052276f55eee5e02dd0578fdf7392178365d))
* **all:** harden detachable client teardown and escape init payload ([#1493](https://github.com/elanthia-online/lich-5/issues/1493)) ([84ce0fb](https://github.com/elanthia-online/lich-5/commit/84ce0fb3be7bc1c772c0089be5d2396bfff75af5))
* **all:** Harden script lifecycle ownership (05 of 06) ([#1478](https://github.com/elanthia-online/lich-5/issues/1478)) ([ec448f1](https://github.com/elanthia-online/lich-5/commit/ec448f1d2e29f94f21d6772b4072551a50e33def))
* **all:** Honor Simu-side teardown for 10 seconds ([#1505](https://github.com/elanthia-online/lich-5/issues/1505)) ([5b27c71](https://github.com/elanthia-online/lich-5/commit/5b27c717d3260bb5e48b30c862aa7686aa2b0e89))
* **all:** identify Genie as the frontend for headless launches ([#1490](https://github.com/elanthia-online/lich-5/issues/1490)) ([67e853e](https://github.com/elanthia-online/lich-5/commit/67e853e44037167a539ddb0daf4b1fd2e74d4b9d))
* **all:** no-op Gtk.lich_main_quit when no main loop is nested ([#1464](https://github.com/elanthia-online/lich-5/issues/1464)) ([0028738](https://github.com/elanthia-online/lich-5/commit/00287384042030c316f33fb3d84e780addce2d04))
* **all:** prevent empty/partial GameObj registry reads during mid-stream refresh ([#1370](https://github.com/elanthia-online/lich-5/issues/1370)) ([e9c5eda](https://github.com/elanthia-online/lich-5/commit/e9c5eda6df04305769f1ee85dace5aef361438db))
* **all:** resolve GameObj status visibility during staged  refresh ([#1497](https://github.com/elanthia-online/lich-5/issues/1497)) ([1b7067d](https://github.com/elanthia-online/lich-5/commit/1b7067da15287bc8f24d354f3edc89d9036a6653))
* **all:** restore detachable client disconnect notice to stdout ([#1492](https://github.com/elanthia-online/lich-5/issues/1492)) ([13b9142](https://github.com/elanthia-online/lich-5/commit/13b9142e870dd205f6d988720fb4b8ca5132dad6))
* **all:** scrub startup credentials once login completes ([#1499](https://github.com/elanthia-online/lich-5/issues/1499)) ([1805df4](https://github.com/elanthia-online/lich-5/commit/1805df4e09cdaa40d8aada11b56cecc9acc4206c))
* **all:** surface the underlying LoadError in dependency alerts ([#1480](https://github.com/elanthia-online/lich-5/issues/1480)) ([1fc7fc8](https://github.com/elanthia-online/lich-5/commit/1fc7fc8723eacdc6097df72aff2946d510af45ef))
* **all:** Synchronize script lifecycle transitions (02 of 06) ([#1475](https://github.com/elanthia-online/lich-5/issues/1475)) ([a6ff9a1](https://github.com/elanthia-online/lich-5/commit/a6ff9a149e3615734d8703f4b0ce944d1e903de6))
* **dr:** common-healing.rb -  DRCH.bind_wound: only dispose a dislodged item while it is in hand ([#1469](https://github.com/elanthia-online/lich-5/issues/1469)) ([422d5a7](https://github.com/elanthia-online/lich-5/commit/422d5a7843b2128269cfe20dd941a794b4c1a702))
* **dr:** equipmanager.rb - reliable ranged-weapon transitions - stow ammo after unload + verify offhand wield hand ([#1468](https://github.com/elanthia-online/lich-5/issues/1468)) ([a1555c0](https://github.com/elanthia-online/lich-5/commit/a1555c026e7c03a41201ab23fcfaf502cc05a27d))
* **dr:** preserve game RealID in room title (GS parity for ";display roomid title") ([#1500](https://github.com/elanthia-online/lich-5/issues/1500)) ([11e9837](https://github.com/elanthia-online/lich-5/commit/11e983770251079bef72587c57c3c58e6961b75b))
* **dr:** reduce symbol-torn scale scrolls to gettable noun ([#1506](https://github.com/elanthia-online/lich-5/issues/1506)) ([5230576](https://github.com/elanthia-online/lich-5/commit/5230576d542818f50411d09d425e8ffd651838cc))
* **dr:** Refine need_buffs? logic for non-recast spells to correctly check cyclic spells. ([#1503](https://github.com/elanthia-online/lich-5/issues/1503)) ([011c372](https://github.com/elanthia-online/lich-5/commit/011c372c9c75f01d647a0815681517d68f8c214f))
* **dr:** resolve no-UID rooms carrying a stored UID instead of returning nil ([#1467](https://github.com/elanthia-online/lich-5/issues/1467)) ([4ba59f3](https://github.com/elanthia-online/lich-5/commit/4ba59f399ffd906bb5200a285cc73f476bcfbab1))


### Refactoring

* **all:** rework map lookup and indexing, drop legacy mapdb formats ([#1495](https://github.com/elanthia-online/lich-5/issues/1495)) ([6d4cd14](https://github.com/elanthia-online/lich-5/commit/6d4cd1499d278415f6f7fdcdd2ccbe425a2ca0c2))
* **all:** Unify script execution and library loading (04 of 06) ([#1477](https://github.com/elanthia-online/lich-5/issues/1477)) ([9ed425a](https://github.com/elanthia-online/lich-5/commit/9ed425a186ecdb2a6fd33acdfa7d91eefc0cf9f7))

## [5.19.1](https://github.com/elanthia-online/lich-5/compare/v5.19.0...v5.19.1) (2026-07-20)


### Bug Fixes

* **all:** Quit Gtk.main cleanly ([#1455](https://github.com/elanthia-online/lich-5/issues/1455)) ([d25e152](https://github.com/elanthia-online/lich-5/commit/d25e152c3ec737b3ed7d35cb11dc05aa9334563f))
* **all:** Refactor regex to string comparisons for ARGV options ([#1456](https://github.com/elanthia-online/lich-5/issues/1456)) ([cec0f60](https://github.com/elanthia-online/lich-5/commit/cec0f60e6489a2c1ffa259975b3d4b159de30dc9))
* **all:** resilient ActiveSessions ownership + shutdown watchdog ([#1452](https://github.com/elanthia-online/lich-5/issues/1452)) ([1eaa043](https://github.com/elanthia-online/lich-5/commit/1eaa043f19a13d61ea963336edd6388d2957c223))
* **gs:** ingest newly-exposed mindState experience and roommeta room fields ([#1450](https://github.com/elanthia-online/lich-5/issues/1450)) ([3339e7d](https://github.com/elanthia-online/lich-5/commit/3339e7d5aebded21685b50121cec37f6d08fba5d))

## [5.19.0](https://github.com/elanthia-online/lich-5/compare/v5.18.0...v5.19.0) (2026-07-17)


### Features

* **all:** add central method to determine lich ver ([#1417](https://github.com/elanthia-online/lich-5/issues/1417)) ([12fd1c4](https://github.com/elanthia-online/lich-5/commit/12fd1c4ebe8f2327c0f7fe9f5da2da99a5368a62))
* **all:** Add character generator support via EAccess protocol ([#1384](https://github.com/elanthia-online/lich-5/issues/1384)) ([bf547a0](https://github.com/elanthia-online/lich-5/commit/bf547a0ff9e624a6d0d46f69cdb5ecef8174a8bc))
* **all:** add macOS limited gem recovery ([#1448](https://github.com/elanthia-online/lich-5/issues/1448)) ([70e8ef7](https://github.com/elanthia-online/lich-5/commit/70e8ef74f830daa3784681901049f7d42e755c22))
* **all:** Add modern script command shutdown method ([#1385](https://github.com/elanthia-online/lich-5/issues/1385)) ([04b4bf9](https://github.com/elanthia-online/lich-5/commit/04b4bf9ccd93b7e6f25edb48b19c1b94b2e44f30))
* **all:** add roomlinks/roommono toggles for room display ([#1438](https://github.com/elanthia-online/lich-5/issues/1438)) ([5baf15f](https://github.com/elanthia-online/lich-5/commit/5baf15f3da2ac8b2b15b2be20a384e9b8f83b002))
* **all:** keyword bind hosts for the detachable client (tailscale/lan/any) ([#1437](https://github.com/elanthia-online/lich-5/issues/1437)) ([bfca33f](https://github.com/elanthia-online/lich-5/commit/bfca33f7b2472079550de77d2d81583094acaf8c))
* **all:** Modify running? method to support optional exact matching of script names ([#1436](https://github.com/elanthia-online/lich-5/issues/1436)) ([b9ae46f](https://github.com/elanthia-online/lich-5/commit/b9ae46fe9aa3df4762f802634ec06b987e336b2f))
* **all:** self-healing gem requires ([#1439](https://github.com/elanthia-online/lich-5/issues/1439)) ([dca2039](https://github.com/elanthia-online/lich-5/commit/dca2039875b79e4a6c7c3e557f773b4ebcf54a5f))
* **all:** setup_files: support scripts/data/custom for user data overrides ([#1431](https://github.com/elanthia-online/lich-5/issues/1431)) ([13b82bc](https://github.com/elanthia-online/lich-5/commit/13b82bc8c8576418bfcedac1c28374eb634d4cab))
* **all:** various Saga FE compatibility tweaks ([#1443](https://github.com/elanthia-online/lich-5/issues/1443)) ([d407d8e](https://github.com/elanthia-online/lich-5/commit/d407d8e76aff834d79ac9b241d119b047769dca2))
* **dr:** Capture combat position from the balance status line ([#1400](https://github.com/elanthia-online/lich-5/issues/1400)) ([5881e4a](https://github.com/elanthia-online/lich-5/commit/5881e4a20d4b890eda46f3796bbece56bbe81185))
* **dr:** detect scheduled shutdown and expose it on DRParser ([#1409](https://github.com/elanthia-online/lich-5/issues/1409)) ([1da0406](https://github.com/elanthia-online/lich-5/commit/1da04062373d22ab76acce1129ee42aa0ce96a70))
* **dr:** Implement DRCA.need_buffs? method for buff checks ([#1428](https://github.com/elanthia-online/lich-5/issues/1428)) ([7e4d9e1](https://github.com/elanthia-online/lich-5/commit/7e4d9e1845fdfb1b6c7b4397844550732ea40ac5))
* **dr:** xmlparser: add structured parser for the assess (combat situation) stream ([#1413](https://github.com/elanthia-online/lich-5/issues/1413)) ([9fe9553](https://github.com/elanthia-online/lich-5/commit/9fe9553d7720bcd941e0b9d1e267cf1b204c46d3))
* **gs:** add creature template library ([#1427](https://github.com/elanthia-online/lich-5/issues/1427)) ([fd8b5ef](https://github.com/elanthia-online/lich-5/commit/fd8b5eff96f8ddee64a26c5d2610c731edc802f1))
* **gs:** creature xml additions ([#1425](https://github.com/elanthia-online/lich-5/issues/1425)) ([4889222](https://github.com/elanthia-online/lich-5/commit/48892224a6e84f8ef73796c93dadc8b4c4d90d1a))
* **main:** add --bind-address option to set listen socket address ([#1405](https://github.com/elanthia-online/lich-5/issues/1405)) ([bc82338](https://github.com/elanthia-online/lich-5/commit/bc82338abbd8cbf897476099feb3ee4a2f4b2970))


### Bug Fixes

* **all:** align --announce with --update for Ruby version ([#1447](https://github.com/elanthia-online/lich-5/issues/1447)) ([e20803c](https://github.com/elanthia-online/lich-5/commit/e20803c403678ddab7abef93170fb26cd29e89ae))
* **all:** bound long-session memory growth (index/hook/watchfor/buffer leaks) ([#1410](https://github.com/elanthia-online/lich-5/issues/1410)) ([85090d4](https://github.com/elanthia-online/lich-5/commit/85090d4df22cde3d2e8f662bb322315c6f8d2786))
* **all:** improve and harden shutdown ([#1416](https://github.com/elanthia-online/lich-5/issues/1416)) ([3b7d377](https://github.com/elanthia-online/lich-5/commit/3b7d3777d369e03e7ca46a87ec652e98583f41a8))
* **all:** increase read timeout on idle socket to 300 seconds ([#1426](https://github.com/elanthia-online/lich-5/issues/1426)) ([cbb06ad](https://github.com/elanthia-online/lich-5/commit/cbb06ade6e8d0d552e7b6dab61ff5063965528d5))
* **all:** Mapdb sort tags by downcase and original case ([#1433](https://github.com/elanthia-online/lich-5/issues/1433)) ([7621993](https://github.com/elanthia-online/lich-5/commit/76219936385014262c532cbd4c413342629078e5))
* **all:** minimum Ruby 4.0 required & migrate Ruby version check ([#1444](https://github.com/elanthia-online/lich-5/issues/1444)) ([0372f6b](https://github.com/elanthia-online/lich-5/commit/0372f6b83f561903fdd3a93609511568fac506c6))
* **all:** monkeypatch gi for memoryreleaser / asyncprocessor until patched upstream ([#1429](https://github.com/elanthia-online/lich-5/issues/1429)) ([56fe509](https://github.com/elanthia-online/lich-5/commit/56fe509119338a1bcb46e6e655956eda8c053636))
* **all:** pin lich directory for gemfile check ([#1423](https://github.com/elanthia-online/lich-5/issues/1423)) ([9b7bad0](https://github.com/elanthia-online/lich-5/commit/9b7bad0f9b502cf557786ed357888b6b4185d713))
* **all:** Show CLI login ARGV for SAL connections ([#1424](https://github.com/elanthia-online/lich-5/issues/1424)) ([071e285](https://github.com/elanthia-online/lich-5/commit/071e285b9131fd8937129860ff609cfe492d7a49))
* **all:** stop locking the load path at boot; keep Gemfile.lock in sync on self-update ([#1434](https://github.com/elanthia-online/lich-5/issues/1434)) ([d3da0eb](https://github.com/elanthia-online/lich-5/commit/d3da0ebb3b0a86a897f0b8c03f88f926661ec1c3))
* **all:** use bundler to check for required Ruby gems ([#1420](https://github.com/elanthia-online/lich-5/issues/1420)) ([7b98d2c](https://github.com/elanthia-online/lich-5/commit/7b98d2c5cc762e6c3a8c2a5adaeae47e4a2fbe29))
* **dr:** BalanceValue regex to match combat status lines ([#1398](https://github.com/elanthia-online/lich-5/issues/1398)) ([7f2448c](https://github.com/elanthia-online/lich-5/commit/7f2448cf756892f14a85aa3fd9f1ad0a08197718)), closes [#1394](https://github.com/elanthia-online/lich-5/issues/1394)
* **dr:** correct fix_standing infinite loop when standing is impossible ([#3668](https://github.com/elanthia-online/lich-5/issues/3668)) ([#1441](https://github.com/elanthia-online/lich-5/issues/1441)) ([29c3e22](https://github.com/elanthia-online/lich-5/commit/29c3e220e5d0dff3447173777be739bb361a6e9d))
* **dr:** equipmanager.rb - Fix unload weapon detection when AimTimerDialog tag is prepended ([#1414](https://github.com/elanthia-online/lich-5/issues/1414)) ([d18c667](https://github.com/elanthia-online/lich-5/commit/d18c6675d38a4165e4fddd76ea4f562507123cc2))
* **dr:** match (prone)/(sitting) posture detection under HidePostStrings ([#4529](https://github.com/elanthia-online/lich-5/issues/4529)) ([#1442](https://github.com/elanthia-online/lich-5/issues/1442)) ([3a1e824](https://github.com/elanthia-online/lich-5/commit/3a1e824cd8820babe2eca9e7f6c4fbf5d44e2ab4))
* **gs:** Currency add method to retrieve aevit event currency ([#1411](https://github.com/elanthia-online/lich-5/issues/1411)) ([53669a5](https://github.com/elanthia-online/lich-5/commit/53669a56d7549ee19f0c58228cc019352d348f75))
* **gs:** global_defs move() update regex for standing condition ([#1407](https://github.com/elanthia-online/lich-5/issues/1407)) ([2e172b2](https://github.com/elanthia-online/lich-5/commit/2e172b28004b116487223fa335af7594a0047102))
* **gs:** global_defs update pushStream regex to include 'reserve' id ([#1379](https://github.com/elanthia-online/lich-5/issues/1379)) ([cc76d50](https://github.com/elanthia-online/lich-5/commit/cc76d50b0e39fc1227bac3794b848d72fc20e564))
* **gs:** psms Warcry.available? correction ([#1387](https://github.com/elanthia-online/lich-5/issues/1387)) ([8414658](https://github.com/elanthia-online/lich-5/commit/84146585c8de01af97ca97bd9a966c6af379edb4))
* **gs:** Stash check result type before comparing regex for wear_to_inv ([#1430](https://github.com/elanthia-online/lich-5/issues/1430)) ([96c0bda](https://github.com/elanthia-online/lich-5/commit/96c0bda57ee73228dd538fc0fa5e09929276b98a))
* **gs:** xmlparser support new field exp, climate, terrain XML feeds ([#1388](https://github.com/elanthia-online/lich-5/issues/1388)) ([97d0474](https://github.com/elanthia-online/lich-5/commit/97d0474a8b371dd3171e1a4b3beb9db7ed0502fb))
* **main:** surface a failed Game.open in the connect timeout ([#1408](https://github.com/elanthia-online/lich-5/issues/1408)) ([c3a79fc](https://github.com/elanthia-online/lich-5/commit/c3a79fc281c0faabb7094fddb4dc94da7582ae59))


### Performance

* **all:** enumerate script subdirs with file glob ([#1397](https://github.com/elanthia-online/lich-5/issues/1397)) ([1a88720](https://github.com/elanthia-online/lich-5/commit/1a8872032cd93646d735742ea871c819ff5d92d2))
* **all:** migrate the server-stream parser from REXML to Ox, with pipe-mode benchmark harness and DR parser coverage ([#1396](https://github.com/elanthia-online/lich-5/issues/1396)) ([6366dc0](https://github.com/elanthia-online/lich-5/commit/6366dc037a851e5c3e51b6f8867fe22cde1f8355))
* **gs:** anchor Infomon parser regex unions to line start ([#1391](https://github.com/elanthia-online/lich-5/issues/1391)) ([7e04141](https://github.com/elanthia-online/lich-5/commit/7e041411b2801e019c6b5d53f985bb507096f002))

## [5.18.0](https://github.com/elanthia-online/lich-5/compare/v5.17.3...v5.18.0) (2026-06-08)


### Features

* **dr:** common-crafting add method for creating mechanisms ([#1375](https://github.com/elanthia-online/lich-5/issues/1375)) ([a341bb1](https://github.com/elanthia-online/lich-5/commit/a341bb1b174842056d6a32662ac4ccfe04c143b1))


### Bug Fixes

* **all:** rubocop custom cop ascii only cleanup ([#1382](https://github.com/elanthia-online/lich-5/issues/1382)) ([eab6757](https://github.com/elanthia-online/lich-5/commit/eab6757ffcefc876938738390a8534fc8d2bf836))
* **all:** stringproc normalize CRLF | CR to LF ([#1378](https://github.com/elanthia-online/lich-5/issues/1378)) ([04bd9ec](https://github.com/elanthia-online/lich-5/commit/04bd9ec519eedd784f56fbc75191e1d4e3382220))
* **dr:** equipmanager update to assume missing items aren't worn ([#1376](https://github.com/elanthia-online/lich-5/issues/1376)) ([4e32548](https://github.com/elanthia-online/lich-5/commit/4e325486b253566eee67588498b22e25e13cbcb9))
* **gs:** Infomon xmlparser additional npc death messaging ([#1326](https://github.com/elanthia-online/lich-5/issues/1326)) ([940894a](https://github.com/elanthia-online/lich-5/commit/940894a4c88f3f2b09e539237ed8372052c47d21))

## [5.17.3](https://github.com/elanthia-online/lich-5/compare/v5.17.2...v5.17.3) (2026-05-30)


### Bug Fixes

* **all:** Add sqlite busy timeout policy to core ([#1365](https://github.com/elanthia-online/lich-5/issues/1365)) ([c6bd57c](https://github.com/elanthia-online/lich-5/commit/c6bd57c5a5ae630ef835febdbacf591790d6f843))
* **all:** reorder shutdown ala MahtraDR and detect script teardown de… ([#1369](https://github.com/elanthia-online/lich-5/issues/1369)) ([5831d98](https://github.com/elanthia-online/lich-5/commit/5831d98fd60f0c1308547152d6ded0fd8ce436ff))
* **all:** Script module replace MemoryReleaser with GC.start for cleanup ([#1364](https://github.com/elanthia-online/lich-5/issues/1364)) ([9a89d26](https://github.com/elanthia-online/lich-5/commit/9a89d26a2e3a08ce032a251b4b7a2ed1e5274919))
* **all:** Script#kill remove GC.start and add optional instrumentation ([#1368](https://github.com/elanthia-online/lich-5/issues/1368)) ([0233e4b](https://github.com/elanthia-online/lich-5/commit/0233e4b30c769ffd6978159a6700f6b60dec1c72))

## [5.17.2](https://github.com/elanthia-online/lich-5/compare/v5.17.1...v5.17.2) (2026-05-24)


### Bug Fixes

* **all:** correct RP timing issue for release notes ([#1348](https://github.com/elanthia-online/lich-5/issues/1348)) ([b85f087](https://github.com/elanthia-online/lich-5/commit/b85f0877a95abdb640ea048686fbe8ba19272b90))
* **all:** gate object cleanup in GTK queue ([#1354](https://github.com/elanthia-online/lich-5/issues/1354)) ([4828aca](https://github.com/elanthia-online/lich-5/commit/4828acab5b2049467b4a266088dfdb2319ef0cb0))
* **all:** harden custom repo identity, collision, and contract boundaries ([#1333](https://github.com/elanthia-online/lich-5/issues/1333)) ([b3d5daf](https://github.com/elanthia-online/lich-5/commit/b3d5daf3db2ac08d54237673c3ed0e59ba67c32b))
* **all:** harden FeatureFlags for closed db handle ([#1335](https://github.com/elanthia-online/lich-5/issues/1335)) ([8195b73](https://github.com/elanthia-online/lich-5/commit/8195b737f55d6ca5d6436d591c6b1efe8fad1ee9))
* **all:** Improve shutdown session state handling ([#1359](https://github.com/elanthia-online/lich-5/issues/1359)) ([db8cf8f](https://github.com/elanthia-online/lich-5/commit/db8cf8f07f8a9fe7949b47b42b04d5eac7c9e9d3))
* **all:** non-ascii hygeine to address rubocop errors ([#1360](https://github.com/elanthia-online/lich-5/issues/1360)) ([a1dfea8](https://github.com/elanthia-online/lich-5/commit/a1dfea84f1532e6a76eccb2c431f3d7336a566cd))
* **all:** recover from cross-process zombie in ActiveSessions service ([#1355](https://github.com/elanthia-online/lich-5/issues/1355)) ([17642a5](https://github.com/elanthia-online/lich-5/commit/17642a52396e10dbc97b0a7d6fc022ebcf61db01))
* **all:** Remove debug log IO from heartbeat tick loop ([#1363](https://github.com/elanthia-online/lich-5/issues/1363)) ([475cefa](https://github.com/elanthia-online/lich-5/commit/475cefaeef3c2b3c97b32d9fab826261f1bb5ddd))
* **all:** stop SessionLifecycle before closing database on normal exit ([#1334](https://github.com/elanthia-online/lich-5/issues/1334)) ([2f0517f](https://github.com/elanthia-online/lich-5/commit/2f0517f269d642e149faf6b95c69bf3d2b0a4739))
* **all:** SynchronizedSocket write resilience and zombie client elimination ([#1338](https://github.com/elanthia-online/lich-5/issues/1338)) ([9c38b4d](https://github.com/elanthia-online/lich-5/commit/9c38b4d845c652098745cb99ef8bd4e26f06c1ce))
* **dr:** DRC text2num correction for thousand ([#1343](https://github.com/elanthia-online/lich-5/issues/1343)) ([ee3528e](https://github.com/elanthia-online/lich-5/commit/ee3528e3a8fb1224795b66d7ba22c95addb49da5))
* **gs:** Overwatch add REVEALED_EXPLODES regex pattern ([#1356](https://github.com/elanthia-online/lich-5/issues/1356)) ([9a14b70](https://github.com/elanthia-online/lich-5/commit/9a14b7052c2f4ea9d4f58e03e575b9be9537a9b9))
* **gs:** Stash add_to_bag result type check before regex compare ([#1357](https://github.com/elanthia-online/lich-5/issues/1357)) ([a6c1061](https://github.com/elanthia-online/lich-5/commit/a6c1061167ed97f1ee0a458b0972665ac8940589))

## [5.17.1](https://github.com/elanthia-online/lich-5/compare/v5.17.0...v5.17.1) (2026-05-07)


### Bug Fixes

* **all:** Add top-level parse_args/display_args bridge to global_defs ([#1346](https://github.com/elanthia-online/lich-5/issues/1346)) ([cca6322](https://github.com/elanthia-online/lich-5/commit/cca6322316b99d7b44bd97121d23e9d4e9adc24c))
* **all:** copy Gemfile and LICENSE during self-update ([#1345](https://github.com/elanthia-online/lich-5/issues/1345)) ([9d56522](https://github.com/elanthia-online/lich-5/commit/9d56522f12d96682bddd90f320cf1c1be00e18ca))
* **all:** enable heartbeat-driven failover for ActiveSessions service owner ([#1340](https://github.com/elanthia-online/lich-5/issues/1340)) ([eb69403](https://github.com/elanthia-online/lich-5/commit/eb694032c67b75a833f141b0c9fdb132a4b04031))
* **dr:** Add CORE_AUTOSTART sentinel to skip dependency.lic autostart helpers ([#1344](https://github.com/elanthia-online/lich-5/issues/1344)) ([c5db210](https://github.com/elanthia-online/lich-5/commit/c5db2103a39cd8ffc19ddd837fd6e34fb6f09ed7))
* **dr:** cache SlackBot users list to prevent API throttling ([#1342](https://github.com/elanthia-online/lich-5/issues/1342)) ([dd7a0c7](https://github.com/elanthia-online/lich-5/commit/dd7a0c702351f7033912ac4c4d88b86426cdcfb3))
* **dr:** replace undefined custom_require in check_moonwatch ([#1336](https://github.com/elanthia-online/lich-5/issues/1336)) ([70df672](https://github.com/elanthia-online/lich-5/commit/70df672f4ea0ed979238d950e92219ca99e67fde))
* **dr:** set_stance places 100 in the correct positional slot ([#1337](https://github.com/elanthia-online/lich-5/issues/1337)) ([2a1ac51](https://github.com/elanthia-online/lich-5/commit/2a1ac518615a9246a1c18bf7befd20af28a57b8b))
* **gs:** add support for RESERVE xml in GameObj.reserve ([#1341](https://github.com/elanthia-online/lich-5/issues/1341)) ([f95a728](https://github.com/elanthia-online/lich-5/commit/f95a728f2538c1f90703b63a5e87e6f7243b6765))
* **gs:** Infomon Status.cutthroat? Effect Debuff correction ([#1331](https://github.com/elanthia-online/lich-5/issues/1331)) ([1af00de](https://github.com/elanthia-online/lich-5/commit/1af00deec063841cae04857fda0b6e11dcbc456c))

## [5.17.0](https://github.com/elanthia-online/lich-5/compare/v5.16.2...v5.17.0) (2026-04-27)


### Features

* **all:** Add get_settings, get_data, start_scripts_if_available to core ([#1305](https://github.com/elanthia-online/lich-5/issues/1305)) ([605aef5](https://github.com/elanthia-online/lich-5/commit/605aef5a067e2082cded356cf885060b19e7815c))
* **all:** Add Map.apply_wayto_overrides for personal map overrides ([#1306](https://github.com/elanthia-online/lich-5/issues/1306)) ([3e0169c](https://github.com/elanthia-online/lich-5/commit/3e0169cebe07be1a70a0355144ee45fecd9b7f61))
* **all:** custom 3rd-party repo support for ScriptSync ([#1285](https://github.com/elanthia-online/lich-5/issues/1285)) ([a2167fc](https://github.com/elanthia-online/lich-5/commit/a2167fcb0936390ae38f26511ca8de24ffbb8f8d))
* **dr:** Add game flags and obsolete script warnings to DRInfomon startup ([#1307](https://github.com/elanthia-online/lich-5/issues/1307)) ([4f1f5fb](https://github.com/elanthia-online/lich-5/commit/4f1f5fbf7135d5c568369f4ebacb0cdcf5e4ae62))
* **dr:** Decouple SetupFiles from script-scoped echo and XML feed timing ([#1304](https://github.com/elanthia-online/lich-5/issues/1304)) ([56939e2](https://github.com/elanthia-online/lich-5/commit/56939e2651b76a135c49c83b10a20e01b5ba74c5))


### Bug Fixes

* **all:** address ActiveSessions lifecycle hot path feature-flag polling ([#1325](https://github.com/elanthia-online/lich-5/issues/1325)) ([1accc54](https://github.com/elanthia-online/lich-5/commit/1accc542fc64b0f86f24b5871a97b20e0968cb36))
* **all:** catch ECONNRESET in _puts and bound walk_to retry depth ([#1327](https://github.com/elanthia-online/lich-5/issues/1327)) ([1362072](https://github.com/elanthia-online/lich-5/commit/136207200fe3a1aca0543686d8d32a2ee486b1e7))
* **all:** enforce beta confirmation 10s timeout ([#1315](https://github.com/elanthia-online/lich-5/issues/1315)) ([6ad4ebb](https://github.com/elanthia-online/lich-5/commit/6ad4ebb1c2fcd2865d9573cd2d245f5119e44c6c))
* **all:** ensure SessionLifecycle.stop runs on abnormal exit ([#1317](https://github.com/elanthia-online/lich-5/issues/1317)) ([a835d19](https://github.com/elanthia-online/lich-5/commit/a835d19c2ffdf08d607edad46a38b21886eab8d0))
* **all:** improve MacOS keychain system check for older OS variants ([#1310](https://github.com/elanthia-online/lich-5/issues/1310)) ([2423bf2](https://github.com/elanthia-online/lich-5/commit/2423bf23c23584842a804d16ffb278f64125b501))
* **all:** prevent zombie server deadlock in Active Sessions accept loop ([#1302](https://github.com/elanthia-online/lich-5/issues/1302)) ([8e32538](https://github.com/elanthia-online/lich-5/commit/8e3253817f25d7a7e7f8433a3b5f348ded7557d1))
* **all:** safeguard gtk logo.png loading ([#1329](https://github.com/elanthia-online/lich-5/issues/1329)) ([f15237a](https://github.com/elanthia-online/lich-5/commit/f15237a9fdf31aa9c595f45e9492357a36360bd8))
* **all:** stub sync_all_repos to prevent leaked thread in games_spec ([#1311](https://github.com/elanthia-online/lich-5/issues/1311)) ([fa0d252](https://github.com/elanthia-online/lich-5/commit/fa0d25219002e581abbd3d89dd310dfd5e8d9ac4))
* **all:** use :__unset for --without-frontend CLI request YAML matches ([#1301](https://github.com/elanthia-online/lich-5/issues/1301)) ([b0b84d8](https://github.com/elanthia-online/lich-5/commit/b0b84d82a3527cef744e8138b6d1367ca6838806))
* **all:** use send(:respond) in StatusReporter fallback path ([#1316](https://github.com/elanthia-online/lich-5/issues/1316)) ([7b56363](https://github.com/elanthia-online/lich-5/commit/7b563634750f1a617b64f0c47e4ab792645cc6a1))
* **gs:** Add InnCheckedOut pattern to parser ([#1309](https://github.com/elanthia-online/lich-5/issues/1309)) ([2aca7e1](https://github.com/elanthia-online/lich-5/commit/2aca7e1c529ab317ece77e700ae92ab3345b76d4))
* **gs:** Claim corrections to handle mounts in room_players stream ([#1324](https://github.com/elanthia-online/lich-5/issues/1324)) ([ea08107](https://github.com/elanthia-online/lich-5/commit/ea0810701a7adcadc4ac2073e053790a627512b5))


### Refactoring

* **all:** CLI consolidation and --help cleanup ([#1314](https://github.com/elanthia-online/lich-5/issues/1314)) ([ad2e9d8](https://github.com/elanthia-online/lich-5/commit/ad2e9d8f0d3c8461c517fc235b4c49e16e3d16a3))
* **dr:** replace EquipmentManager verb_data hardcoded patterns with DRCI constants ([#1313](https://github.com/elanthia-online/lich-5/issues/1313)) ([088e968](https://github.com/elanthia-online/lich-5/commit/088e968a0d96404303dd3b7a07299b38e24ff0c3))

## [5.16.2](https://github.com/elanthia-online/lich-5/compare/v5.16.1...v5.16.2) (2026-03-29)


### Bug Fixes

* **all:** repair regression on gui button reenable from refactor ([#1297](https://github.com/elanthia-online/lich-5/issues/1297)) ([f10b1f9](https://github.com/elanthia-online/lich-5/commit/f10b1f95f4c1f0720505d5823e43f334b3c12d62))

## [5.16.1](https://github.com/elanthia-online/lich-5/compare/v5.16.0...v5.16.1) (2026-03-29)


### Bug Fixes

* **all:** fix three revert bugs in SnapshotManager ([#1289](https://github.com/elanthia-online/lich-5/issues/1289)) ([fa87aa0](https://github.com/elanthia-online/lich-5/commit/fa87aa0e8a804343be329145ab147d8f738b886c))
* **all:** guard nil release asset and validate before deleting lib/ ([#1290](https://github.com/elanthia-online/lich-5/issues/1290)) ([b8e3002](https://github.com/elanthia-online/lich-5/commit/b8e3002e206771b1a6937ddcdb1d630e01600b84))
* **all:** guard nil stable version in beta channel resolution ([#1291](https://github.com/elanthia-online/lich-5/issues/1291)) ([c5c42c6](https://github.com/elanthia-online/lich-5/commit/c5c42c6a5e5042a97aeb250a0c8e142259cb830a))
* **all:** narrow safe_write rollback scope so cleanup failure preserves successful write ([#1287](https://github.com/elanthia-online/lich-5/issues/1287)) ([8974813](https://github.com/elanthia-online/lich-5/commit/8974813089c3fd274a62dc049336792be89e7421))
* **all:** remove dead code in BranchInstaller ([#1292](https://github.com/elanthia-online/lich-5/issues/1292)) ([b3c480a](https://github.com/elanthia-online/lich-5/commit/b3c480a18245ccb37060effd6e65597758e098b3))
* **dr:** forward vitality and dead fields in perceive_health ([#1288](https://github.com/elanthia-online/lich-5/issues/1288)) ([cad008c](https://github.com/elanthia-online/lich-5/commit/cad008c24736fce9370f1807f5d1a71c5ff8e688))

## [5.16.0](https://github.com/elanthia-online/lich-5/compare/v5.15.1...v5.16.0) (2026-03-28)


### Features

* **all:** Add active sessions API ([#1274](https://github.com/elanthia-online/lich-5/issues/1274)) ([094c355](https://github.com/elanthia-online/lich-5/commit/094c355c05a29eefc1ffc23a565b6505b0c6615a))
* **all:** add core classes, ScriptSync, and login auto-sync ([#1273](https://github.com/elanthia-online/lich-5/issues/1273)) ([3ccdfb3](https://github.com/elanthia-online/lich-5/commit/3ccdfb38076c5717f9bbdb867af77c26ba0fcdd7))
* **all:** Add session status CLI query ([#1276](https://github.com/elanthia-online/lich-5/issues/1276)) ([91e90f7](https://github.com/elanthia-online/lich-5/commit/91e90f7c4c36cb1620c0c710acf59428172cd0ba))
* **all:** configurable debug log retention ([#1282](https://github.com/elanthia-online/lich-5/issues/1282)) ([03d908d](https://github.com/elanthia-online/lich-5/commit/03d908d6fc433546095594fd27f955969e2803df))
* **all:** session summary store and reporting ([#1247](https://github.com/elanthia-online/lich-5/issues/1247)) ([36ec701](https://github.com/elanthia-online/lich-5/commit/36ec70170e7acb6e56c6da2e78d7fe6f08a7861a))
* **dr:** common-healing.rb - add vitality parsing to HealthResult ([#1265](https://github.com/elanthia-online/lich-5/issues/1265)) ([8a65de0](https://github.com/elanthia-online/lich-5/commit/8a65de0d705a86c42b8fbbf6396f0f80232d32fc))


### Bug Fixes

* **all:** handle auth exceptions in manual login to prevent hang on bad password ([#1267](https://github.com/elanthia-online/lich-5/issues/1267)) ([05dfe30](https://github.com/elanthia-online/lich-5/commit/05dfe306dd9a2d64f54d97b0dc14511e00a8be03))
* **all:** log and re-raise unexpected errors in saved login auth handler ([#1271](https://github.com/elanthia-online/lich-5/issues/1271)) ([5ea9501](https://github.com/elanthia-online/lich-5/commit/5ea950199d83ddc97fb5aa241d70e42a71c9d0bd))
* **all:** Persistent Launcher re-enable play button post launch ([#1269](https://github.com/elanthia-online/lich-5/issues/1269)) ([72d532f](https://github.com/elanthia-online/lich-5/commit/72d532f43b0f12fd925ca75e2f7d9447a72508a1))
* **all:** Restore manual login behaviors to not require saved entry t… ([#1270](https://github.com/elanthia-online/lich-5/issues/1270)) ([5eb6d4f](https://github.com/elanthia-online/lich-5/commit/5eb6d4f3c492a6a9961a55a785100eed06ec965a))
* **all:** set SO_REUSEADDR before bind to allow immediate port reuse ([#1268](https://github.com/elanthia-online/lich-5/issues/1268)) ([9db4b6b](https://github.com/elanthia-online/lich-5/commit/9db4b6be4882b300bf5531e7020aa2808d9d13ab))
* **dr:** buffer_room_objs missed split components with leading stream tags ([#1284](https://github.com/elanthia-online/lich-5/issues/1284)) ([e858d91](https://github.com/elanthia-online/lich-5/commit/e858d91746075d1c5b713826e9683ef5710c3f73))
* **dr:** common-items.rb - get_item_unsafe false positives via XML feed verification ([#1286](https://github.com/elanthia-online/lich-5/issues/1286)) ([b3c286f](https://github.com/elanthia-online/lich-5/commit/b3c286f38442007098ab3038dcfbf804f9fb57c0))
* **dr:** common-items.rb - move pattern from failure to success block ([#1262](https://github.com/elanthia-online/lich-5/issues/1262)) ([7209d3a](https://github.com/elanthia-online/lich-5/commit/7209d3add9a908c3f377b16fb207b49b3f783a7d))
* **gs:** Infomon xmlparser additional npc death messaging ([#1275](https://github.com/elanthia-online/lich-5/issues/1275)) ([517f7cf](https://github.com/elanthia-online/lich-5/commit/517f7cfa77d86cc44e2bcb40cf7f6e4bf39700f3))
* **gs:** Infomon xmlparser additional npc death messaging ([#1281](https://github.com/elanthia-online/lich-5/issues/1281)) ([d66dc50](https://github.com/elanthia-online/lich-5/commit/d66dc50b76712147c7ec082c1476e64f0f46d620))


### Documentation

* **all:** add DeepWiki auto-docs ([#1280](https://github.com/elanthia-online/lich-5/issues/1280)) ([f9cbd45](https://github.com/elanthia-online/lich-5/commit/f9cbd45bcbebe126078dde94f2518d6fc4840e51))

## [5.15.1](https://github.com/elanthia-online/lich-5/compare/v5.15.0...v5.15.1) (2026-03-16)


### Bug Fixes

* **all:** add timeout safety to fput to prevent infinite hangs ([#1261](https://github.com/elanthia-online/lich-5/issues/1261)) ([79176c3](https://github.com/elanthia-online/lich-5/commit/79176c3b07c46fe4fed920ed70714bc23b4b3913))
* **all:** guard against broken pipe errors in Game._puts and send_to_client ([#1260](https://github.com/elanthia-online/lich-5/issues/1260)) ([995cefd](https://github.com/elanthia-online/lich-5/commit/995cefd3ade131c5a819e3a6f649f7a2e4f95470))
* **all:** Mutli-launch persistent login GUI ([#1245](https://github.com/elanthia-online/lich-5/issues/1245)) ([3e4a873](https://github.com/elanthia-online/lich-5/commit/3e4a873131311e57da32f029ccb2a9e70bc5211d))
* **all:** Remove Windows OS CMD prompt flash ([#1255](https://github.com/elanthia-online/lich-5/issues/1255)) ([26b7581](https://github.com/elanthia-online/lich-5/commit/26b7581394d48d821e235c33050b274bf2d246ec))
* **dr:** add bounded recursion depth limits to 9 methods ([#1257](https://github.com/elanthia-online/lich-5/issues/1257)) ([fea0776](https://github.com/elanthia-online/lich-5/commit/fea0776172c0aa64e8cf0bf0c47fed407478ee00))
* **dr:** anchor stow success pattern to prevent fan close recovery bypass ([#1254](https://github.com/elanthia-online/lich-5/issues/1254)) ([c96933d](https://github.com/elanthia-online/lich-5/commit/c96933dee8f15be6409530592a42b021c8bcf259))
* **dr:** stow_helper failure detection + unload_weapon ammo recovery ([#1259](https://github.com/elanthia-online/lich-5/issues/1259)) ([d010383](https://github.com/elanthia-online/lich-5/commit/d0103835bf18f595440ef22743ee0164254ae373))


### Refactoring

* **all:** reorganize specs to mirror lib/ and fix spec issues ([#1250](https://github.com/elanthia-online/lich-5/issues/1250)) ([32ed5ac](https://github.com/elanthia-online/lich-5/commit/32ed5ac4fa4c6bc425d240774bfa239957c33ee7))
* **dr:** consolidate DRCI/EquipmentManager patterns, YARD docs, bug fixes ([#1256](https://github.com/elanthia-online/lich-5/issues/1256)) ([375b9a0](https://github.com/elanthia-online/lich-5/commit/375b9a0a7640c370a0a437ce822843dbe67436df))
* **dr:** DRY extraction of duplicated patterns in DRCI/EquipmentManager ([#1258](https://github.com/elanthia-online/lich-5/issues/1258)) ([82e613b](https://github.com/elanthia-online/lich-5/commit/82e613b44a8cd0ce39954299079f58b82b8178ff))


### Documentation

* **all:** add YARD documentation style guide and .yardopts ([#1252](https://github.com/elanthia-online/lich-5/issues/1252)) ([5915eda](https://github.com/elanthia-online/lich-5/commit/5915eda658141e17ce9a939d76ffeaa864c77ef2))

## [5.15.0](https://github.com/elanthia-online/lich-5/compare/v5.14.2...v5.15.0) (2026-03-09)


### Features

* **all:** add InstanceSettings for core Settings API access ([#1233](https://github.com/elanthia-online/lich-5/issues/1233)) ([6de17eb](https://github.com/elanthia-online/lich-5/commit/6de17eb36119f78a34b8ba3f6ee4ac16e1071b9e))
* **gs:** Overwatch module into core ([#1201](https://github.com/elanthia-online/lich-5/issues/1201)) ([70dee4b](https://github.com/elanthia-online/lich-5/commit/70dee4bd617de4ee8c38ec8b585fc9a56fd100b5))


### Bug Fixes

* **all:** Exit quickly on CLI authentication failure ([#1237](https://github.com/elanthia-online/lich-5/issues/1237)) ([f177cd0](https://github.com/elanthia-online/lich-5/commit/f177cd0f5434139767d0b3494a4640bf1d480a1d))
* **all:** fix GameObj container initialization and add clear_all_containers ([#1226](https://github.com/elanthia-online/lich-5/issues/1226)) ([2a9a6da](https://github.com/elanthia-online/lich-5/commit/2a9a6daa6a9327e903e8f1dc59d0421b290970bd))
* **all:** GameObj object dedupe & GC ([#1234](https://github.com/elanthia-online/lich-5/issues/1234)) ([6a48812](https://github.com/elanthia-online/lich-5/commit/6a4881280aa7f656aee103fdd92c37e72fd5dfe2))
* **all:** script.rb show Script.kill source ([#1235](https://github.com/elanthia-online/lich-5/issues/1235)) ([fbbf04c](https://github.com/elanthia-online/lich-5/commit/fbbf04cf02cdbb3cabda3f163d6094c6bcd78d36))
* **all:** suppress wine detection noise and skip when unneeded ([#1244](https://github.com/elanthia-online/lich-5/issues/1244)) ([dfcd813](https://github.com/elanthia-online/lich-5/commit/dfcd81395d7a827d088654579e810924a28c283a))
* **dr:** DR modules fixes and enhancements ([#1232](https://github.com/elanthia-online/lich-5/issues/1232)) ([4c63805](https://github.com/elanthia-online/lich-5/commit/4c63805bb3f5aca6c059d9b3922ce8b85b8fe60d))
* **gs:** Bounty parser fix regex pattern for skin retrieval task ([#1242](https://github.com/elanthia-online/lich-5/issues/1242)) ([d480143](https://github.com/elanthia-online/lich-5/commit/d4801435018b6f988ab5db4b3d74318f11668205))
* **gs:** psms.rb add additional failure matches ([#1238](https://github.com/elanthia-online/lich-5/issues/1238)) ([4ce94d2](https://github.com/elanthia-online/lich-5/commit/4ce94d247132a9c26dd4285f30e048ee3702e769))


### Refactoring

* **all:** Add frontend registry for capability-based configuration ([#1223](https://github.com/elanthia-online/lich-5/issues/1223)) ([c1dcc19](https://github.com/elanthia-online/lich-5/commit/c1dcc192233a02d131de19d9723e100876abb862))
* **all:** Consolidate authentication code under lib/common/authentication ([#1240](https://github.com/elanthia-online/lich-5/issues/1240)) ([14a2ce3](https://github.com/elanthia-online/lich-5/commit/14a2ce3c59fbacdfc5e43793ea98a332b9de7430))
* **dr:** Comprehensive DR modules refactor ([#1231](https://github.com/elanthia-online/lich-5/issues/1231)) ([9bc7914](https://github.com/elanthia-online/lich-5/commit/9bc79144d09bd27aed927044a19c0da575642eab))
* **dr:** dragonrealms drinfomon audit - DRY/SOLID/robustness improvements ([#1243](https://github.com/elanthia-online/lich-5/issues/1243)) ([0478671](https://github.com/elanthia-online/lich-5/commit/04786718e8136394239193a2516f5979f83e539f))
* **dr:** use yaml wire-brush-number in repair_own_tools ([#1241](https://github.com/elanthia-online/lich-5/issues/1241)) ([931a579](https://github.com/elanthia-online/lich-5/commit/931a579db0412f683577c927248db87baeb4819e))

## [5.14.2](https://github.com/elanthia-online/lich-5/compare/v5.14.1...v5.14.2) (2026-02-18)


### Bug Fixes

* **all:** add retry with exponential backoff for all login authentication ([#1205](https://github.com/elanthia-online/lich-5/issues/1205)) ([ff365ef](https://github.com/elanthia-online/lich-5/commit/ff365ef783cdd6803ce01e811b6ecf2cb5937859))
* **all:** update.rb allow for bugfix betas and branch updates ([#1211](https://github.com/elanthia-online/lich-5/issues/1211)) ([2d60245](https://github.com/elanthia-online/lich-5/commit/2d602450d38c19724b09fa9527776a49a642f907))
* **gs:** infomon.rb bug in _key transformation ([#1216](https://github.com/elanthia-online/lich-5/issues/1216)) ([46bfc81](https://github.com/elanthia-online/lich-5/commit/46bfc811d41bb3d0d80911b9e64b6fb6ca13186b))

## [5.14.1](https://github.com/elanthia-online/lich-5/compare/v5.14.0...v5.14.1) (2026-02-12)


### Bug Fixes

* **all:** change encodings in main.rb to wizard FE only ([#1199](https://github.com/elanthia-online/lich-5/issues/1199)) ([fe43007](https://github.com/elanthia-online/lich-5/commit/fe4300702392b8b4c1720ac3f988cc2fa56d2bf9))
* **all:** Change server_time_offset in XMLParser to be float instead of int ([#1184](https://github.com/elanthia-online/lich-5/issues/1184)) ([2e26e8e](https://github.com/elanthia-online/lich-5/commit/2e26e8ea7af4c8ccb208af19a806a9005e8d7526))
* **gs:** Infomon parser.rb bug in EnhanciveEnd ([#1198](https://github.com/elanthia-online/lich-5/issues/1198)) ([fe20c7b](https://github.com/elanthia-online/lich-5/commit/fe20c7b069157f4e244f19d376a117fa0c6f11a0))
* **gs:** Infomon parser.rb update Account.subscription/type ([#1192](https://github.com/elanthia-online/lich-5/issues/1192)) ([698d1da](https://github.com/elanthia-online/lich-5/commit/698d1daf7da2d50fa330f84f4f60180e7ec21033))
* **gs:** spell.rb add last_cast to track last time casted ([#1193](https://github.com/elanthia-online/lich-5/issues/1193)) ([67115dd](https://github.com/elanthia-online/lich-5/commit/67115dd0b6bfbedc118de0740dc61f57603740a0))
* **gs:** stash.rb additional improvements with ReadyList/StowList ([#1197](https://github.com/elanthia-online/lich-5/issues/1197)) ([5ef1c85](https://github.com/elanthia-online/lich-5/commit/5ef1c859f188f506af2c7b29faa2b7b344035e21))

## [5.14.0](https://github.com/elanthia-online/lich-5/compare/v5.13.6...v5.14.0) (2026-02-07)


### Features

* **all:** Add Genie map cross-reference fields to the DragonRealms map data model ([#1169](https://github.com/elanthia-online/lich-5/issues/1169)) ([1e7c1dd](https://github.com/elanthia-online/lich-5/commit/1e7c1dde11025e5fe8bdbdf9f562f97bb4a84a2c))
* **dr:** DRExpMonitor move into core lich ([#1154](https://github.com/elanthia-online/lich-5/issues/1154)) ([48524b9](https://github.com/elanthia-online/lich-5/commit/48524b9a1bef7089f371df5bb0073792ef287023))
* **gs:** add Enhancive module for enhancive item bonus tracking ([#1113](https://github.com/elanthia-online/lich-5/issues/1113)) ([61cff8f](https://github.com/elanthia-online/lich-5/commit/61cff8f7fb0155c6ebf8096186bed1cd8fc023e9))
* **gs:** add QStrike module for optimal stamina-based RT reduction ([#1114](https://github.com/elanthia-online/lich-5/issues/1114)) ([b10af81](https://github.com/elanthia-online/lich-5/commit/b10af81f1ec8ad6143f58e1565968312d469a62e))


### Bug Fixes

* **all:** map_base.rb sort JSON better ([#1171](https://github.com/elanthia-online/lich-5/issues/1171)) ([7e60e68](https://github.com/elanthia-online/lich-5/commit/7e60e68c1dc310ebe87a10cbf25696287cf7f4bc))
* **all:** remove strip! from settingsInfo replacement ([#1161](https://github.com/elanthia-online/lich-5/issues/1161)) ([aef52ad](https://github.com/elanthia-online/lich-5/commit/aef52add62c47daa73579ac69e13db0352c34cdd))
* **dr:** logbook_item recovery when crafted item not in hand ([#1175](https://github.com/elanthia-online/lich-5/issues/1175)) ([da18fa9](https://github.com/elanthia-online/lich-5/commit/da18fa95e602fdae0ee1cc256212fed4eaaba00d))
* **gs:** stash.rb ReadyList sheath handling and update inventory checks ([#1166](https://github.com/elanthia-online/lich-5/issues/1166)) ([7aeec90](https://github.com/elanthia-online/lich-5/commit/7aeec90f8faf8a4cef881317ab7719d6858c7b78))
* **gs:** xmlparser.rb capture additional death messaging ([#1158](https://github.com/elanthia-online/lich-5/issues/1158)) ([02293d1](https://github.com/elanthia-online/lich-5/commit/02293d1ce3b771a02b7a37176158b0ec4e09c766))


### Refactoring

* **all:** Centralize frontend capability checks in Frontend module ([#1170](https://github.com/elanthia-online/lich-5/issues/1170)) ([26e4e00](https://github.com/elanthia-online/lich-5/commit/26e4e003429a3577e4e025aed5917ceaba2bee58))
* **all:** Map update for robustness and maintainability ([#1163](https://github.com/elanthia-online/lich-5/issues/1163)) ([b803822](https://github.com/elanthia-online/lich-5/commit/b8038229e80b84c9d47577e8865b2970ce65e565))
* **all:** Refactor game initialization process ([#1162](https://github.com/elanthia-online/lich-5/issues/1162)) ([b90bcf9](https://github.com/elanthia-online/lich-5/commit/b90bcf97be6a404da1db6d238ad70aa7857ce958))

## [5.13.6](https://github.com/elanthia-online/lich-5/compare/v5.13.5...v5.13.6) (2026-01-26)


### Bug Fixes

* **all:** allow --add-account to run without yaml and dat ([#1143](https://github.com/elanthia-online/lich-5/issues/1143)) ([ca48153](https://github.com/elanthia-online/lich-5/commit/ca48153f36c96d70728142d1e5621ed82b2e7750))
* **all:** Allow hmr to work on global_defs.rb ([#1156](https://github.com/elanthia-online/lich-5/issues/1156)) ([b077c8a](https://github.com/elanthia-online/lich-5/commit/b077c8a6fca3cd6059606a834014b3b25b6cb3a3))
* **all:** enable --login for multi-variable custom launch commands ([#1144](https://github.com/elanthia-online/lich-5/issues/1144)) ([0464b2d](https://github.com/elanthia-online/lich-5/commit/0464b2d2e781a4aed1e1d8469bbd54689272ca62))
* **all:** messaging.rb return "" for xml_encode with Wizard ([#1147](https://github.com/elanthia-online/lich-5/issues/1147)) ([96a5a7f](https://github.com/elanthia-online/lich-5/commit/96a5a7f17b2f6d57ec456a2fcf798bf8c76a2a7c))
* **all:** prevent closing connection on module reload ([#1148](https://github.com/elanthia-online/lich-5/issues/1148)) ([2540a14](https://github.com/elanthia-online/lich-5/commit/2540a1497fd301996be3e0d8466b1b065979b733))
* **all:** update.rb pervent update if MIN_RUBY not met ([#1146](https://github.com/elanthia-online/lich-5/issues/1146)) ([24b5173](https://github.com/elanthia-online/lich-5/commit/24b5173a55400f4fff78d7f3677a85912de239cf))
* **dr:** add buffering for multiline room players ([#1151](https://github.com/elanthia-online/lich-5/issues/1151)) ([c7c2cc7](https://github.com/elanthia-online/lich-5/commit/c7c2cc78459e01b1507f0469dbca43eb631bc0de))
* **dr:** add verify_script def here instead of depending on dependency ([#1155](https://github.com/elanthia-online/lich-5/issues/1155)) ([21560de](https://github.com/elanthia-online/lich-5/commit/21560de0c7ccebb3cd1c6259c78de3eea7e801b4))
* **dr:** buffer split room obj lines and merge instead of appending closing tag to broken line ([#1149](https://github.com/elanthia-online/lich-5/issues/1149)) ([b8dd4a2](https://github.com/elanthia-online/lich-5/commit/b8dd4a2f3d25f45d89843eb58624db4e07f246d6))
* **gs:** infomon.rb added updated_at field to upsert_batch ([#1145](https://github.com/elanthia-online/lich-5/issues/1145)) ([ff2b4b5](https://github.com/elanthia-online/lich-5/commit/ff2b4b551e4f9438c9a28c74fd98ed1c15c6a9e2))
* **gs:** readylist.rb check method fix when dead ([#1153](https://github.com/elanthia-online/lich-5/issues/1153)) ([29729f4](https://github.com/elanthia-online/lich-5/commit/29729f45fa731af2a74d21bc48daa45fd0988f48))
* **gs:** stowlist.rb check method fix when dead ([#1152](https://github.com/elanthia-online/lich-5/issues/1152)) ([ddf3a12](https://github.com/elanthia-online/lich-5/commit/ddf3a12472ab026ab8fb74e1610a3bb50f38c220))

## [5.13.5](https://github.com/elanthia-online/lich-5/compare/v5.13.4...v5.13.5) (2026-01-16)


### Bug Fixes

* **all:** add --gs and --dr, refactor argv_options to helpers ([#1133](https://github.com/elanthia-online/lich-5/issues/1133)) ([a809a26](https://github.com/elanthia-online/lich-5/commit/a809a26cb9694fa699855dd91de6888aa906c514))
* **all:** fix multiple custom entries, improvements to yaml save ([#1134](https://github.com/elanthia-online/lich-5/issues/1134)) ([86e69a3](https://github.com/elanthia-online/lich-5/commit/86e69a353ca323cc922fc06abddca3b61f62c0ff))
* **all:** login_tab_utils.rb expand helper text show Warlock ([#1135](https://github.com/elanthia-online/lich-5/issues/1135)) ([1b43e0d](https://github.com/elanthia-online/lich-5/commit/1b43e0d12b5afa88207ac017b03d790519c260d3))
* **all:** reduce minimum GUI window footprint for non-tabbed view ([#1138](https://github.com/elanthia-online/lich-5/issues/1138)) ([79b18ed](https://github.com/elanthia-online/lich-5/commit/79b18ed2d70d5ae56bd01477ec859acb4508e220))
* **all:** remove double save in YAML to preserve yaml.bak integrity ([#1139](https://github.com/elanthia-online/lich-5/issues/1139)) ([0c26110](https://github.com/elanthia-online/lich-5/commit/0c2611081c37a4167a5a729d7da1b1b34e5aa96f))
* **all:** remove password parameter from debug logging in all cases ([#1137](https://github.com/elanthia-online/lich-5/issues/1137)) ([fe21beb](https://github.com/elanthia-online/lich-5/commit/fe21beb7bdd8ddaa8b7c7ec6254165587bbc2162))
* **all:** update CLI for YAML security signature, add auto-convert fo… ([#1136](https://github.com/elanthia-online/lich-5/issues/1136)) ([b1c690a](https://github.com/elanthia-online/lich-5/commit/b1c690af39b2ac045b8413a3f83b57defa264b70))
* **all:** util.rb only show gem installing debug messaging if gem mis… ([#1131](https://github.com/elanthia-online/lich-5/issues/1131)) ([dd55334](https://github.com/elanthia-online/lich-5/commit/dd55334351715dda9feea214ed91bf59563ef754))
* **gs:** stash.rb additional improvements ([#1132](https://github.com/elanthia-online/lich-5/issues/1132)) ([8a8d906](https://github.com/elanthia-online/lich-5/commit/8a8d906a4da56e2719789e0679e70bb88bae45b4))

## [5.13.4](https://github.com/elanthia-online/lich-5/compare/v5.13.3...v5.13.4) (2026-01-14)


### Bug Fixes

* **all:** add window size / position saves to login GUI ([#1128](https://github.com/elanthia-online/lich-5/issues/1128)) ([4a22a1e](https://github.com/elanthia-online/lich-5/commit/4a22a1eb88a9a754af857711263d0174682e6ae9))
* **all:** force system gem install if RubyGems fails ([#1126](https://github.com/elanthia-online/lich-5/issues/1126)) ([4b43170](https://github.com/elanthia-online/lich-5/commit/4b431701718143f339670924dd52599f9a9dea2c))
* **all:** gui_login prevent destroying window if already destroyed ([#1127](https://github.com/elanthia-online/lich-5/issues/1127)) ([3dd8808](https://github.com/elanthia-online/lich-5/commit/3dd880865cc3d9713ffda0e2f8a1218ca5833b7b))
* **all:** non tabbed saved entries in reduced button / font size (not… ([#1129](https://github.com/elanthia-online/lich-5/issues/1129)) ([2ec9f0b](https://github.com/elanthia-online/lich-5/commit/2ec9f0b5b7e507df493657f98f1f1eeaf7e608cb))

## [5.13.3](https://github.com/elanthia-online/lich-5/compare/v5.13.2...v5.13.3) (2026-01-14)


### Bug Fixes

* **all:** account manager sorting GUI fix ([#1123](https://github.com/elanthia-online/lich-5/issues/1123)) ([4457f4b](https://github.com/elanthia-online/lich-5/commit/4457f4b2b509751a4dd25489f957c1fb0ecfecf4))

## [5.13.2](https://github.com/elanthia-online/lich-5/compare/v5.13.1...v5.13.2) (2026-01-14)


### Bug Fixes

* **all:** install_gem_requirements update available gems after install ([#1120](https://github.com/elanthia-online/lich-5/issues/1120)) ([782b00b](https://github.com/elanthia-online/lich-5/commit/782b00bcabb014558340fd006df16d4dea765742))

## [5.13.1](https://github.com/elanthia-online/lich-5/compare/v5.13.0...v5.13.1) (2026-01-14)


### Bug Fixes

* **all:** password_cipher.rb upcase account_name for key ([#1118](https://github.com/elanthia-online/lich-5/issues/1118)) ([e4d41dc](https://github.com/elanthia-online/lich-5/commit/e4d41dc9e15d4bd0effd4b520d8a3dfc0479eb0d))
* **dr:** validator.rb change sleep to should_sleep named param ([#1116](https://github.com/elanthia-online/lich-5/issues/1116)) ([58e9168](https://github.com/elanthia-online/lich-5/commit/58e9168bde5c36f91f683a5e7cb305320cc7fc05))
* **gs:** add base stats capture from 'info full' command ([#1115](https://github.com/elanthia-online/lich-5/issues/1115)) ([1086093](https://github.com/elanthia-online/lich-5/commit/1086093608914555f664f0eea462c3881ab2419e))

## [5.13.0](https://github.com/elanthia-online/lich-5/compare/v5.12.12...v5.13.0) (2026-01-13)


### Features

* **all:** add simplified DB maintenance ([#991](https://github.com/elanthia-online/lich-5/issues/991)) ([894f50d](https://github.com/elanthia-online/lich-5/commit/894f50d451683a53d3eebc059aa8b5a8be7ac4ae))
* **all:** Login modernization and refactor to yaml ([#1063](https://github.com/elanthia-online/lich-5/issues/1063)) ([dda2bb6](https://github.com/elanthia-online/lich-5/commit/dda2bb60eacf1b6e03ae0d6478d1d56fc4593cc1))
* **all:** Refocus Frontend ([#960](https://github.com/elanthia-online/lich-5/issues/960)) ([72222d1](https://github.com/elanthia-online/lich-5/commit/72222d1dd954b441da05717407823dfa45563872))
* **all:** Ruby Memory Releaser module ([#1066](https://github.com/elanthia-online/lich-5/issues/1066)) ([038eef2](https://github.com/elanthia-online/lich-5/commit/038eef21485e637a954acc355a34b2f0c502778b))
* **all:** socket configurator to better guard TCPSocket ([#976](https://github.com/elanthia-online/lich-5/issues/976)) ([f35034c](https://github.com/elanthia-online/lich-5/commit/f35034ca69cddf4d0268b8f19fc5b76cc53a279a))
* **all:** TextStripper module support for XML, HTML, Markdown ([#1055](https://github.com/elanthia-online/lich-5/issues/1055)) ([7dc09b3](https://github.com/elanthia-online/lich-5/commit/7dc09b3e3c3d9c3d229d68f5ea070d2a195b76ee))
* **dr:** Add GameObj.inv support for DR items ([#1080](https://github.com/elanthia-online/lich-5/issues/1080)) ([c521917](https://github.com/elanthia-online/lich-5/commit/c521917ac2a6d11296a0baa74ef4f17053e84f60))
* **dr:** DRCS allow custom adjective for summoned weapons ([#1088](https://github.com/elanthia-online/lich-5/issues/1088)) ([2790d8c](https://github.com/elanthia-online/lich-5/commit/2790d8c2dbc1001306d0f3711af2ae5e5800feb2))
* **dr:** DRParser support for new exp window xml stream elements (rested exp, tdps, favors) ([#1104](https://github.com/elanthia-online/lich-5/issues/1104)) ([ba6a1cf](https://github.com/elanthia-online/lich-5/commit/ba6a1cf7ba2d45f496232290d25df4089bfd4be8))
* **dr:** support meta:trashcan tag for DRCI.dispose_trash ([#966](https://github.com/elanthia-online/lich-5/issues/966)) ([d6a08ed](https://github.com/elanthia-online/lich-5/commit/d6a08ed730206750e9c978a5763476a842644874))
* **gs:** Add Armaments (Weapon, Armor, and Shield) Module ([#911](https://github.com/elanthia-online/lich-5/issues/911)) ([4dd3d40](https://github.com/elanthia-online/lich-5/commit/4dd3d404e94d5da1a54267dc63d900a7d225cdb6))
* **gs:** add creature module, including Hinterwilds creatures ([#1002](https://github.com/elanthia-online/lich-5/issues/1002)) ([ff65c1e](https://github.com/elanthia-online/lich-5/commit/ff65c1eb744bd4a950ad1bb741b42c7261dbcc9c))
* **gs:** add Injured class for checking ability to perform actions ([#1035](https://github.com/elanthia-online/lich-5/issues/1035)) ([e97a74d](https://github.com/elanthia-online/lich-5/commit/e97a74dac26c780b7d5fadff06e0064d79559b0d))
* **gs:** Creature module combat tracking ([#1003](https://github.com/elanthia-online/lich-5/issues/1003)) ([452a34a](https://github.com/elanthia-online/lich-5/commit/452a34ae90b944e993fa4fe147f3301481753529))
* **gs:** track time of last total_experience record ([#1030](https://github.com/elanthia-online/lich-5/issues/1030)) ([e9b31b7](https://github.com/elanthia-online/lich-5/commit/e9b31b7a5413a62a99aeaae4edcd700a6d8abe22))


### Bug Fixes

* **all:** [lib][global-defs] - move update ([#1079](https://github.com/elanthia-online/lich-5/issues/1079)) ([a5b69ae](https://github.com/elanthia-online/lich-5/commit/a5b69aeefda773d8ff745978cbe5c62feaac79b2))
* **all:** change Hash[] pair key conversion to use to_h for Ruby 4.0 ([#1108](https://github.com/elanthia-online/lich-5/issues/1108)) ([3af9467](https://github.com/elanthia-online/lich-5/commit/3af9467d3261ee172d31f4f4b8537f00e3be01fc))
* **all:** ensure proxy path is set for non-destructive array write-th… ([#1073](https://github.com/elanthia-online/lich-5/issues/1073)) ([546fa6b](https://github.com/elanthia-online/lich-5/commit/546fa6b9f54bdb0018c32a4e3f236f3fd577a870))
* **all:** GameObj force new objects ID to be string ([#1087](https://github.com/elanthia-online/lich-5/issues/1087)) ([2c467b8](https://github.com/elanthia-online/lich-5/commit/2c467b8b40a98cffc5609e8c056936ef2c681bb1))
* **all:** map dijkstra optimization ([#1061](https://github.com/elanthia-online/lich-5/issues/1061)) ([782df48](https://github.com/elanthia-online/lich-5/commit/782df481960e0dea30d392144f044a14a0d4c249))
* **all:** move gui-login.rb to Ruby standard gui_login.rb ([#1111](https://github.com/elanthia-online/lich-5/issues/1111)) ([47abb8f](https://github.com/elanthia-online/lich-5/commit/47abb8ff8817d2e4f1528647af0b1020cfee21c3))
* **all:** update location for currency and move game-loader.rb to Ruby standard gameloader.rb ([#1112](https://github.com/elanthia-online/lich-5/issues/1112)) ([39bbb60](https://github.com/elanthia-online/lich-5/commit/39bbb6094f16380d1e4ecd6c080d6199faef170d))
* **all:** update.rb keep script/data file incase of error on update ([#1070](https://github.com/elanthia-online/lich-5/issues/1070)) ([2f09881](https://github.com/elanthia-online/lich-5/commit/2f09881dd7df27c84abb07c1daff6fbdab04d087))
* **all:** xmlparser.rb gate GSL exits sending behind [@send](https://github.com/send)_fake_tags ([#1103](https://github.com/elanthia-online/lich-5/issues/1103)) ([053319d](https://github.com/elanthia-online/lich-5/commit/053319d883c0c3dec0ccebf2978c19f9dc7ba3b1))
* **dr:** DRCA allow custom spell prep messaging ([#1089](https://github.com/elanthia-online/lich-5/issues/1089)) ([42f5025](https://github.com/elanthia-online/lich-5/commit/42f502575a7a45abcad76aab41b2ef133712e586))
* **dr:** equipmanager.rb support for custom messaging in forester's longbow ([#1105](https://github.com/elanthia-online/lich-5/issues/1105)) ([557fab5](https://github.com/elanthia-online/lich-5/commit/557fab5f02e49008cce3ad71b1c4bb2d2eaa169a))
* **dr:** Fix exp mods parsing for DR ([#1102](https://github.com/elanthia-online/lich-5/issues/1102)) ([dbb50ed](https://github.com/elanthia-online/lich-5/commit/dbb50ed6bff5aa7e3f46e44ed08d660cee09591a))
* **dr:** Fix hang in equipment manager when game doesn't respond to commands ([#1110](https://github.com/elanthia-online/lich-5/issues/1110)) ([34c394a](https://github.com/elanthia-online/lich-5/commit/34c394abbe04baa8cf1546e6005d5fb81280a90f))
* **dr:** Update Slackbot error handling, and lnet management ([#1091](https://github.com/elanthia-online/lich-5/issues/1091)) ([f729c69](https://github.com/elanthia-online/lich-5/commit/f729c690fb1221b0e39ff6ed309a8e6c5427751a))
* **gs:** Bounty parser.rb FWI guard regex update ([#1096](https://github.com/elanthia-online/lich-5/issues/1096)) ([036a2c5](https://github.com/elanthia-online/lich-5/commit/036a2c5d1090e9806deb4c1181abcdfba6ed591e))
* **gs:** cman.rb add hamstring regex for already lying down target ([#1090](https://github.com/elanthia-online/lich-5/issues/1090)) ([79e2b91](https://github.com/elanthia-online/lich-5/commit/79e2b91a9932ea10c916fca126d0d1a67ba9f6b8))
* **gs:** cman.rb hamstring regex update when can't perform on target ([#1092](https://github.com/elanthia-online/lich-5/issues/1092)) ([966aa78](https://github.com/elanthia-online/lich-5/commit/966aa78bd33ba8af9a3744e13e46fa6b113f4917))
* **gs:** currency.rb track gold ([#1109](https://github.com/elanthia-online/lich-5/issues/1109)) ([f51c351](https://github.com/elanthia-online/lich-5/commit/f51c35145d7289964f437b084652ab7110222042))
* **gs:** Infomon additional CHE resign regex ([#1067](https://github.com/elanthia-online/lich-5/issues/1067)) ([94108ef](https://github.com/elanthia-online/lich-5/commit/94108ef5ecb19ea86eafd711d6fb33ef5f3f2f15))
* **gs:** Resource tracking for sorcerer shadow essence ([#1085](https://github.com/elanthia-online/lich-5/issues/1085)) ([7730550](https://github.com/elanthia-online/lich-5/commit/7730550fd05b6e403d6fe0bf3c23dd68dc093d88))

## [5.12.12](https://github.com/elanthia-online/lich-5/compare/v5.12.11...v5.12.12) (2025-11-09)


### Bug Fixes

* **all:** Update module strip markdown comments ([#1056](https://github.com/elanthia-online/lich-5/issues/1056)) ([44693ba](https://github.com/elanthia-online/lich-5/commit/44693ba017a076ca65d572d86dd0fca47076c659))
* **all:** Vars/UserVars module fixes and corrections ([#1057](https://github.com/elanthia-online/lich-5/issues/1057)) ([7338ef1](https://github.com/elanthia-online/lich-5/commit/7338ef189ac03289daeb72fddb3ae7a22a2ed4ba))
* **gs:** Infomon parse fix for singular currency ([#1051](https://github.com/elanthia-online/lich-5/issues/1051)) ([eea0ea3](https://github.com/elanthia-online/lich-5/commit/eea0ea3e45dcfeb85a19721fdd39eb85862125c1))


### Documentation

* **gs:** Group API YARD additions ([#1048](https://github.com/elanthia-online/lich-5/issues/1048)) ([e4a611f](https://github.com/elanthia-online/lich-5/commit/e4a611f137eb05b4c0a8394dc07563d5141ecc04))

## [5.12.11](https://github.com/elanthia-online/lich-5/compare/v5.12.10...v5.12.11) (2025-10-31)


### Bug Fixes

* **dr:** add bput match for system updates preventing actions ([#1034](https://github.com/elanthia-online/lich-5/issues/1034)) ([5df10f1](https://github.com/elanthia-online/lich-5/commit/5df10f1f8d75598bfea52caf2467e9bad92f7041))
* **dr:** drdefs.rb npc parsing ([#1038](https://github.com/elanthia-online/lich-5/issues/1038)) ([328c2b2](https://github.com/elanthia-online/lich-5/commit/328c2b29fd8f7d8efb017a55086ded77d30ac4b9))
* **dr:** Fix container reference in get_item_from_eddy_portal method ([#1039](https://github.com/elanthia-online/lich-5/issues/1039)) ([20a3f09](https://github.com/elanthia-online/lich-5/commit/20a3f093925616d8ebd133e04847ae1eea817692))
* **gs:** bounty location regex needs to match "under" ([#1037](https://github.com/elanthia-online/lich-5/issues/1037)) ([6358ba3](https://github.com/elanthia-online/lich-5/commit/6358ba305e8c9cd5acb8f0340069f2812e7cc648))

## [5.12.10](https://github.com/elanthia-online/lich-5/compare/v5.12.9...v5.12.10) (2025-10-18)


### Bug Fixes

* **all:** games.rb catch additional error for nested single/double qu… ([#1031](https://github.com/elanthia-online/lich-5/issues/1031)) ([7e572cf](https://github.com/elanthia-online/lich-5/commit/7e572cfbb8a8682d022ced5fd2ccce829be74518))
* **dr:** change keys for DR_SKILLS_DATA[:guild_skill_aliases] to be strings instead of symbols ([#1032](https://github.com/elanthia-online/lich-5/issues/1032)) ([1fc7510](https://github.com/elanthia-online/lich-5/commit/1fc75105ea378b204503dd0538bcd153ccff2f38))
* **gs:** Bounty parser for SG npcs matching ([#1027](https://github.com/elanthia-online/lich-5/issues/1027)) ([f4e993f](https://github.com/elanthia-online/lich-5/commit/f4e993f6299b595d0dd713939cc4093daa0c87a4))
* **gs:** match READY/STOW items with a/an/some inside the link ([#1026](https://github.com/elanthia-online/lich-5/issues/1026)) ([e57561a](https://github.com/elanthia-online/lich-5/commit/e57561a611d1d07c974e4255b461be60c09d98fd))

## [5.12.9](https://github.com/elanthia-online/lich-5/compare/v5.12.8...v5.12.9) (2025-10-03)


### Bug Fixes

* **gs:** StowList/ReadyList reset bug if non-default keys added ([#1019](https://github.com/elanthia-online/lich-5/issues/1019)) ([c97d86d](https://github.com/elanthia-online/lich-5/commit/c97d86d65664e5defc252f7687fe6d918c54b4c7))

## [5.12.8](https://github.com/elanthia-online/lich-5/compare/lich-5-v5.12.7...lich-5/v5.12.8) (2025-09-28)


### Bug Fixes

* **all:** script.rb show custom at script exit as well ([#993](https://github.com/elanthia-online/lich-5/issues/993)) ([dfe92dd](https://github.com/elanthia-online/lich-5/commit/dfe92ddbc8a20a4b51e98c048bdd81379ff4e425))
* **all:** Updated update.rb for single trunk and release please ([#1001](https://github.com/elanthia-online/lich-5/issues/1001)) ([7840b3d](https://github.com/elanthia-online/lich-5/commit/7840b3d7d4e3e19a1c6bb226fb614f737471a41c))
