import re
import enum

class InstrType(enum.IntEnum):
    Undefinied = 0
    Call = 1
    Cmp = 2
    Bin = 3
    Alloca = 4
    Cast = 5
    AddrOp = 6
    CondBr = 7
    UncondBr = 8
    Store = 9
    Load = 10
    Other = 11

Instr_Dict = {
    "Undefinied": InstrType.Undefinied,
    "Call": InstrType.Call,
    "Cmp": InstrType.Cmp,
    "Bin": InstrType.Bin,
    "alloca": InstrType.Alloca,
    "cast": InstrType.Cast,
    "Addr Op": InstrType.AddrOp,
    "Cond br": InstrType.CondBr,
    "Uncond br": InstrType.UncondBr,
    "Store": InstrType.Store,
    "Load": InstrType.Load,
    "LA": InstrType.Other
}

TYPE_IND_TO_STR = ["Undefinied",
    "Call",
    "Cmp",
    "Bin",
    "alloca",
    "cast",
    "Addr Op",
    "Cond br",
    "Uncond br",
    "Store",
    "Load",
    "LA",]

class TraceRecord:

    def __init__(self, line):
        # Define a regular expression pattern to match the desired format
        pattern = r'\[(.*?)\] (.*?) (.*)'

        # Use re.match to search for the pattern in the line
        match = re.match(pattern, line)

        # If a match is found, extract the components
        if match:
            self.match = True
            self.type = match.group(1)
            self.func = match.group(2)
            self.opname = match.group(3)
        else: # Log All func was called
            self.match = False
            print(f"[Err] In Parser:\nLine: {line}Pattern: {pattern}\n")

    def __str__(self):
        if self.match:
            return f"{self.type} {self.func} {self.opname}"
        else:
            return "None"#f"[ERR] No match to pattern"
        
    def match_type(self):
        if self.type in Instr_Dict:
            self.instr_type = int(Instr_Dict[self.type])
        else:
            print("[Err] Undefinied Instr Type")
            self.instr_type = int(InstrType.Undefinied)


class Trace:
    def __init__(self, trace_records):
        self.trace_records = trace_records
        self.valid_trace = self.is_trace_valid()

    def is_trace_valid(self):
        for trace in self.trace_records:
            if not trace.match:
                return False
        return True

    def instr_type_to_str(self, instr_type):
        return TYPE_IND_TO_STR[instr_type]
        #return list(Instr_Dict.keys())[list(Instr_Dict.values()).index(instr_type)]

    def get_count_instr_type_str(self):
        ret_str = ""
        for i, instr_count in enumerate(self.count_list):
            ret_str += f"[{self.instr_type_to_str(i)}] {instr_count}\n"
        return ret_str

    def __str__(self):
        if not self.valid_trace:
            return "Trace status: Invalid"
        else:
            return f"Trace status: Valid\n" + self.get_count_instr_type_str()
    
    # count how many uses for each instruction type
    def count_instr_type(self):
        if (not self.valid_trace):
            print("Can't count instrs types on invalid trace")
            return
        self.count_list = [0 for _ in range(len(Instr_Dict))]
        for trace_record in self.trace_records:
            trace_record.match_type()
            self.count_list[trace_record.instr_type] += 1
 
        #print(f"Count List:\n{self.count_list}")





def file_to_lines(filepath):
    # Generator to read rows in a text file
    with open (filepath, 'r') as f:
        lines = [line for line in f]
        print(f"Lines: {len(lines)}")
        return lines[0:6000000]


def main():
    file_lines = file_to_lines("log.txt")
    print("[State] File loaded")
    trace_records = [TraceRecord(line) for line in file_lines]
    print("[State] Trace records builded")
    trace = Trace(trace_records)
    print("[State] Trace builded")
    trace.count_instr_type()
    print("[State] Instructions types counted")
    print(trace)



if __name__ == "__main__":
    main()
    print("[Done]")