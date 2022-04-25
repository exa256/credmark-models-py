from typing import List, Optional, TypedDict, Union

from credmark.cmf.model.errors import ModelBaseError
from credmark.dto import DTO
from models.utils.term_colors import TermColors


class ExampleModelOutputInfo(TypedDict):
    github_url: str
    documentation_url: str


class _ExampleModelOutput(DTO):

    # TODO: Replace it with a Discriminated Union
    class Log(DTO):
        type: str
        message: Optional[str] = None
        input: Optional[str] = None
        output: Optional[str] = None
        error: Optional[str] = None

    title: str
    description: str = ""
    github_url: str
    documentation_url: str
    logs: List[Log] = []

    def __init__(self, **data):
        super().__init__(**data)
        self._log('\n' + TermColors.apply(data["title"], invert=True))
        if data["description"] != "":
            self._log(TermColors.apply(data["description"], faint=True))
        self._log('\n> ' + TermColors.apply("Docs", underline=True) + "   " + data["documentation_url"])
        self._log('> ' + TermColors.apply("Source", underline=True) + " " + data["github_url"])

    def _log(self, message: str):
        print(message)

    def log(self, message: str):
        self._log('\n'+TermColors.apply(message, TermColors.BLUE))
        self.logs.append(self.Log(type="message", message=message))

    def log_io(self, input: str, output):
        str_to_log = ""
        normalized_input = input.lstrip("\n").replace("\n", "\n\t")
        if normalized_input != "":
            str_to_log += "\n>>> "
            highlighted_input = TermColors.apply(normalized_input, TermColors.GREEN)
            str_to_log += highlighted_input

        if isinstance(output, DTO):
            output = output.dict()

        if output != "":
            highlighted_output = TermColors.apply(str(output), TermColors.YELLOW)
            str_to_log += "\n"
            str_to_log += highlighted_output

        self._log(str_to_log)
        self.logs.append(self.Log(type="io", input=input, output=str(output)))

    def log_error(self, error: Union[str, Exception]):
        error_str = ""
        if isinstance(error, str):
            error_str = error
        elif isinstance(error, ModelBaseError):
            error_str = error.data.message
        else:
            error_str = str(error)
        self._log('\n' + TermColors.apply(error_str, TermColors.RED))
        self.logs.append(self.Log(type="error", error=error_str))


# __init__ with kwargs disables type hints
# This hack re-enables type hints
# TODO: Use `Unpacked` from typing_extensions for kwargs type
class ExampleModelOutput(_ExampleModelOutput):
    pass
