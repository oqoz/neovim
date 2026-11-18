# Personal Neovim

[lazy.nvim](https://github.com/folke/lazy.nvim)으로 플러그인을 관리하는 개인 Neovim 설정.
LazyVim starter에서 출발했지만 현재 LazyVim 런타임이나 extras에는 의존하지 않는다.
옵션, 키맵, 진단 표시와 각 플러그인의 설정을 이 저장소에서 직접 관리한다.

## 설치

현재 검증한 Neovim 버전은 **0.12.6**이며, 0.12.x 환경을 권장한다.

필요한 도구:

- Git: lazy.nvim 및 플러그인 설치.
- `fzf`, `rg`(ripgrep), `fd`: 파일 및 프로젝트 본문 검색.
- `uv`의 `uvx`: Python의 ty, Ruff 실행. `uvx`가 PATH에 있어야 한다.
- Nerd Font: 진단과 파일 아이콘을 표시하려면 터미널에 설정한다.
- 사용할 언어의 LSP와 포맷터: 아래의 언어 도구 항목 참고.

기존 `~/.config/nvim`이 있다면 먼저 별도로 백업하거나 다른 경로에서 구성을 검토한다.
설정 디렉터리가 비어 있는 새 환경에서는 다음과 같이 설치한다.

```sh
git clone https://github.com/oqoz/neovim.git ~/.config/nvim
nvim
```

첫 실행에는 네트워크 연결이 필요하다. lazy.nvim이 자신과 선언된 플러그인을 설치한다.
`~/.local/bin`은 Neovim의 PATH에 추가되며, Zellij 안에서는 OSC 52 클립보드를 사용한다.

## 구성

| 역할 | 구성 요소 |
| --- | --- |
| 플러그인 설치·로드·버전 관리 | lazy.nvim |
| 테마 / 상태줄 | Modus / lualine.nvim |
| 파일 탐색 / 버퍼 탭 | oil.nvim / bufferline.nvim |
| 파일·본문·버퍼 검색 | fzf-lua |
| 자동 완성 / 괄호 자동 닫기 | blink.cmp v1 / mini.pairs |
| LSP 설정 / 외부 언어 도구 설치 | nvim-lspconfig / Mason·mason-lspconfig |
| 저장 시 포맷 | conform.nvim |
| 명령창·알림 | noice.nvim + nui.nvim |
| 부드러운 스크롤 | snacks.nvim의 scroll 기능만 활성화 |
| 분할 배치를 유지하는 버퍼 닫기 | mini.bufremove + 저장 확인 함수 |
| 다중 커서 | multiple-cursors.nvim |

기본 로딩 정책은 시작 시 로드다. mini.pairs는 `InsertEnter`, Conform은 저장 또는
명령 실행 시, fzf-lua는 명령·모듈 사용 시, Noice는 `VeryLazy`에 로드된다.
자동 업데이트 확인은 켜져 있지만 자동 업데이트나 업데이트 알림은 켜지지 않는다.

### 파일 역할

```text
init.lua                    리더 키와 초기화 순서
lua/config/
  lazy.lua                  플러그인 매니저 초기화
  options.lua               편집기 옵션과 기본 들여쓰기
  keymaps.lua               키맵과 마우스 입력 차단
  autocmds.lua              창 크기 변경 후 스크롤 거리 복원
  buffers.lua               저장 확인 및 안전한 버퍼 닫기
  diagnostics.lua           진단 아이콘·메시지 설정과 토글
  finder.lua                검색의 Git 루트 선택
lua/plugins/
  appearance.lua            Modus 하이라이트와 lualine
  bufferline.lua            버퍼 탭과 닫기 동작
  editing.lua               자동 괄호, Rust 따옴표 처리
  explorer.lua              Oil 플로팅 창과 디렉터리 키맵
  finder.lua                fzf-lua 표시 설정
  formatting.lua            파일타입별 포맷터와 저장 훅
  lsp.lua                   자동 완성, LSP 및 Mason 연동
  noice.lua                 중앙 명령창과 우하단 알림
  scrolling.lua             키보드 스크롤 애니메이션
  tools.lua                 다중 커서
  example.lua               기본적으로 아무것도 설치하지 않는 빈 예제
lazy-lock.json              플러그인별 고정 커밋
stylua.toml                 이 저장소의 Lua 포맷 규칙
```

새 플러그인은 `lua/plugins/`에 독립적인 lazy.nvim spec으로 추가한다.
일반 옵션·키맵과 플러그인 전용 설정은 구분해서 둔다.

## 키맵

리더 키는 `Space`, 로컬 리더 키는 `\`다.
아래 표는 이 설정에서 추가하거나 바꾼 동작이다.

### 일반 모드

| 키 | 동작 |
| --- | --- |
| `Space e` | 둥근 테두리의 Oil 플로팅 창 열기 / 닫기 |
| `Space Space` | 파일 검색 |
| `Space /` | 프로젝트 파일의 내용 검색 |
| `Space ,` | 열린 버퍼 검색 |
| `Shift+h` / `Shift+l` | 버퍼 탭 순서대로 이전 / 다음 버퍼 |
| `Space b d` | 저장 확인 후 버퍼 닫기. 분할 창 배치는 유지 |
| `;;` | 모든 버퍼의 줄 끝 진단 메시지 표시 / 숨김 |
| `E` (`Shift+e`) | 현재 줄의 진단 상세 보기. 진단 출처와 코드 포함 |
| `Ctrl+d` / `Ctrl+u` | 아래 / 위로 기본 6줄 이동 |
| `Ctrl+l` | 현재 단어의 일치 항목에 다중 커서 추가 |
| `Ctrl+a` | 파일 전체 선택 |
| `dw` | 개인 매핑 `bved` 실행 |

단일 `;`, `q`, `m`의 일반 모드 기본 동작은 비활성화되어 있다.
`[[` / `]]`는 버퍼 이동으로 덮어쓰지 않고 파일타입의 기본 동작을 유지한다.

분할은 Neovim 기본 키를 사용한다.

- `Ctrl+w` 다음 `v`: 좌우 분할, 다음 `s`: 상하 분할.
- `Ctrl+w` 다음 `h/j/k/l`: 해당 방향 창으로 이동.
- `Ctrl+w` 다음 `q`: 현재 창 닫기. 마지막 창이면 Neovim 종료.

### 삽입·시각 모드

| 모드 | 키 | 동작 |
| --- | --- | --- |
| 삽입 | `jj` | 일반 모드로 전환 |
| 삽입 | `jk` | 일반 모드로 전환하고 명시적으로 저장 |
| 삽입 | `Ctrl+h/j/k/l` | 왼쪽 / 아래 / 위 / 오른쪽 이동 |
| 삽입 | `Tab` | Blink의 자동 완성·스니펫 동작, 해당 상황이 아니면 파일의 들여쓰기 설정 사용 |
| 시각 | `Tab` / `Shift+Tab` | 언어·프로젝트 설정에 따라 들여쓰기 / 내어쓰기, 선택 유지 |
| 시각 | `Ctrl+l` | 일치 항목에 다중 커서 추가 |
| 시각 | `q` | 선택 해제 |

### Oil 안에서

| 키·명령 | 동작 |
| --- | --- |
| `Space e` | 플로팅 창 닫고 원래 편집 창으로 복귀 |
| `Enter` | 파일 또는 디렉터리 열기 |
| `-` | 상위 디렉터리 |
| `;;` / `g.` | 숨김 파일 표시 / 숨김 |
| `Ctrl+c` | Oil 닫기 |
| `:w` | 파일명·디렉터리 편집 내용을 확인 후 적용 |

숨김 파일은 기본적으로 숨긴다. Oil의 `;;`는 버퍼 전용 매핑이므로 진단 메시지를 토글하지 않는다.
파일 작업을 위한 자동 저장도 사용하지 않는다.

## 편집 동작

- 현재 줄은 실제 줄 번호, 나머지는 상대 줄 번호를 표시한다.
- Neovim 내부의 마우스 클릭·드래그·휠 입력은 비활성화한다.
  중간 터미널 계층이 전달하는 마우스 이벤트도 무시한다. 터미널 자체의 선택 기능은 별개다.
- `Ctrl+d/u`의 기본 6줄 이동은 창 분할·리사이즈 후에도 유지한다.
  아주 작은 창에서는 창 높이까지 제한한다.
- 키보드 스크롤은 최대 150ms, 빠른 반복은 최대 50ms로 애니메이션한다.
  Oil, 터미널 버퍼와 플로팅 창에는 적용하지 않는다.
- 기본 들여쓰기는 공백 2칸이며, 파일타입 플러그인과 내장 EditorConfig 설정이 우선한다.
  예를 들어 Python/Rust는 공백 4칸, Go/Makefile은 해당 파일의 탭 설정을 따른다.
- `tabstop`은 실제 탭 문자의 표시 폭이고, `shiftwidth`는 들여쓰기 단위다.
  Tab 입력과 시각 모드 들여쓰기를 표시 폭 8칸으로 강제하지 않는다.
- Backspace 한 칸 삭제를 강제하지 않는다. 해당 파일의 들여쓰기 설정을 따른다.
- 줄 끝 공백은 `⋅`로 표시한다. 이 표시는 공백을 삭제하는 기능이 아니다.
- 자동 저장은 사용하지 않는다. 명시적인 저장 때만 포맷한다.
  저장하지 않은 변경을 닫을 때는 확인하며, `Space b d`의 취소는 버퍼와 창을 그대로 둔다.

## LSP·포맷터

### Python

Mason으로 Python 도구를 중복 설치하지 않고 다음 명령으로 실행한다.

```sh
uvx ty server
uvx ruff server
```

ty와 Ruff의 진단을 둘 다 사용한다. hover 정보는 ty가 담당하고,
Ruff는 린트·빠른 수정·fix-all·organize imports 및 포맷을 담당한다.
저장 시에는 Conform이 `uvx ruff format`을 사용한다.

### Lua·Rust·C/C++

필요한 서버를 `:Mason`에서 설치한다. 예를 들면:

```vim
:MasonInstall lua-language-server rust-analyzer clangd stylua
```

`ensure_installed`는 비어 있으므로 새 환경에서 서버를 무조건 설치하지 않는다.
설치한 LSP는 mason-lspconfig가 활성화하며, 실제 연결은 서버의 파일타입·프로젝트 루트 조건을 따른다.
Neovim 설정 디렉터리의 Lua 프로젝트에는 `vim` API 정의를 추가하지만,
다른 Lua 프로젝트의 전역 변수 진단을 통째로 끄지는 않는다.

| 파일타입 | 저장 시 포맷터 |
| --- | --- |
| Python | `uvx ruff format` |
| Lua | `stylua` |
| Rust | `rustfmt` |

StyLua는 Mason으로 설치할 수 있다. Rustfmt는 Rust 툴체인에서 준비한다.
포맷은 저장 전에 최대 2초 동안 실행하며, 별도 포맷터가 적용되지 않으면 LSP 포맷을 fallback으로 사용한다.

### 진단 표시

기본적으로 코드 undercurl, 왼쪽 심각도 아이콘과 줄 번호 색상만 표시한다.
`;;`를 누르면 줄 끝 메시지도 표시하고, 다시 누르면 숨긴다. 진단 수집 자체를 끄는 것은 아니다.

줄 끝에는 메시지만 표시하며, ` <-` 접두사와 Modus의 심각도별 전경·배경색을 사용한다.
진단 출처와 코드는 `E`로 여는 상세 창에서 확인한다.
LSP 시작 알림이나 진행 표시는 서버가 실제로 메시지를 보낼 때 나타난다.

## 관리·문제 확인

| 명령 | 용도 |
| --- | --- |
| `:Lazy` | 플러그인 상태와 작업 UI |
| `:Lazy check` | 업데이트 확인 |
| `:Lazy update` | 의도적으로 플러그인을 업데이트하고 lockfile 갱신 |
| `:Lazy restore` | 현재 lockfile에 기록된 플러그인 커밋으로 복원 |
| `:Lazy clean` | 더 이상 선언하지 않는 플러그인의 로컬 설치 정리 |
| `:Lazy profile` | 플러그인 로드 시간 확인 |
| `:Mason` | 언어 서버와 외부 도구 설치 상태 |
| `:ConformInfo` | 현재 파일의 포맷터와 실행 상태 |
| `:checkhealth vim.lsp` | LSP 상태와 구성 확인 |
| `:Noice history` | 알림·명령 메시지 기록 |
| `:setlocal sw? sts? ts? et?` | 현재 버퍼의 들여쓰기 옵션 확인 |

업데이트할 때는 설정과 `lazy-lock.json`의 변경을 함께 검토하고 커밋한다.
문제가 생기면 원하는 이전 커밋의 설정·lockfile로 돌아간 뒤 `:Lazy restore`를 실행한다.
명령의 자세한 동작은 [lazy.nvim 사용 문서](https://lazy.folke.io/usage)를 참고한다.

`lazy-lock.json`이 고정하는 것은 Neovim 플러그인이다.
Mason 패키지, `uvx` 도구와 언어 툴체인의 버전은 별도로 관리해야 한다.
로컬 에이전트 상태·로그·개인 설정 디렉터리는 Git에서 제외한다.

## 라이선스

[LICENSE](LICENSE)를 참고한다. 시작 템플릿의 기존 라이선스 표기는 유지한다.
