#This is not writed by miyagaw61 full (little edited by miyagaw61)(used by calc)


import math, re, sys, operator





class Operator:

    P_CST=6          
    P_LHB=5          
    P_FUN=4          
    P_POW=3          
    P_UPM=2          
    P_MD=1           
    P_BPM=0          

    
    def __init__(self, name, fun, priority):
        self.name=name
        self.fun=fun
        self.priority=priority

    def __call__(self, x=None, y=None):
        return self.fun        if self.is_const() else                    \
               self.fun(x)     if self.is_unary() or self.is_lhb() else   \
               self.fun(x, y)

    def __gt__(self, other):
        assert other is None or isinstance(other, Operator)
        return other is None or \
          self.priority > other.priority or \
          ( self.priority in (Operator.P_FUN, Operator.P_POW, Operator.P_UPM) and self.priority == other.priority)

    def __str__(self):
        return self.name

    def __repr__(self):
        return repr(self.name)

    def is_const(self):
        return self.priority==Operator.P_CST

    def is_lhb(self):
        return self.priority==Operator.P_LHB

    def is_upm(self):
        return self.priority==Operator.P_UPM

    def is_func(self):
        return self.priority==Operator.P_FUN

    def is_unary(self):
        return self.priority in (Operator.P_FUN, Operator.P_UPM)

    def is_binary(self):
        return self.priority in (Operator.P_POW, Operator.P_MD, Operator.P_BPM)




def is_natural(n):
    
    return type(n) is int and n>=0



def fact(n):
    
    assert is_natural(n)
    return reduce(operator.__mul__, range(1, n+1)) if n>0 else 1


    
def permutation(m,n):
    
    assert is_natural(m) and is_natural(n) and m>=n
    return reduce(operator.__mul__, range(m-n+1, m+1), 1)


    
def combination(m,n):
    
    assert is_natural(m) and is_natural(n) and m>=n
    return permutation(m,n)/fact(n)







L_OP= [ \
  Operator('@+', operator.__pos__, Operator.P_UPM), \
  Operator('@-', operator.__neg__, Operator.P_UPM), \
  Operator('+', operator.__add__, Operator.P_BPM),\
  Operator('-', operator.__sub__, Operator.P_BPM), \
  Operator('*', operator.__mul__, Operator.P_MD),\
  Operator('/', operator.__truediv__, Operator.P_MD), \
  Operator('%', operator.__mod__, Operator.P_MD), \
  Operator('<<', operator.__lshift__, Operator.P_POW), \
  Operator('>>', operator.__rshift__, Operator.P_POW), \
  Operator('**', math.pow, Operator.P_POW), \
  Operator('^', math.pow, Operator.P_POW), \
  Operator('exp', math.exp, Operator.P_FUN), \
  Operator('log', math.log, Operator.P_FUN), \
  Operator('log10', math.log10, Operator.P_FUN), \
  Operator('sqrt', math.sqrt, Operator.P_FUN),  \
  Operator('abs', operator.__abs__, Operator.P_FUN), \
  Operator('sin', math.sin, Operator.P_FUN), \
  Operator('cos', math.cos, Operator.P_FUN), \
  Operator('tan', math.tan, Operator.P_FUN), \
  Operator('asin', math.asin, Operator.P_FUN), \
  Operator('acos', math.acos, Operator.P_FUN), \
  Operator('atan', math.atan, Operator.P_FUN), \
  Operator('!', fact, Operator.P_LHB), \
  Operator('P', permutation, Operator.P_POW), \
  Operator('C', combination, Operator.P_POW), \
  Operator('pi', math.pi, Operator.P_CST), \
  Operator('e', math.e, Operator.P_CST), \
  ]


H_OP=dict([(str(op), op)  for op in L_OP])


def convert_op_name(op):
    

    return ''.join([(c if c.isalnum() else '\\'+c) for c in str(op)]) + \
             (r'(?=\W|$)' if op.is_const() else r'(?=[\s\(])' if op.is_func() else '')
    



RE_FORM = re.compile( \
r'''(?P<nest>\()                                            |   
    (?P<num>\d+(?P<after_dot>\.\d+)?(?:[eE][+-]?\d+)?)      |   
    (?P<op_name>%s)                                             
''' % ('|'.join([ convert_op_name(op)  for op in sorted([op for op in L_OP if not op.is_upm()], key=lambda x:len(str(x)), reverse=True)]),), \
 re.VERBOSE)





def cons(obj, ls):
    
    ls.append(obj)
    return ls



def operator_position (ls):
    

    tprev, term0, pos = None, None, -1
    
    for i, term in enumerate(ls):
        if isinstance(term, Operator) and (term > term0 or (isinstance(tprev, Operator) and term.is_upm())):
            term0, pos = term, i
        tprev=term
            
    return term0, pos



def eval_ls(ls):
    

    if operator.isNumberType(ls): return ls   
    elif len(ls)==1:
        i=ls[0]
        return eval_ls(i() if isinstance(i, Operator) else i)    
    else:
        op, pos =operator_position(ls)  

        if op.is_const(): 
            return eval_ls(cons(op(), ls[:pos]) + ls[pos+1:])
        
        elif op.is_unary() and pos < len(ls)-1: 
            return eval_ls(cons(op(eval_ls(ls[pos+1])), ls[0:pos]) + ls[pos+2:])
            
        elif op.is_lhb() and pos>0: 
            return eval_ls(cons(op(eval_ls(ls[pos-1])), ls[0:pos-1]) + ls[pos+1:])
            
        elif op.is_binary() and 0 < pos < len(ls)-1: 
            return eval_ls(cons(op( eval_ls(ls[pos-1]), eval_ls(ls[pos+1]) ), ls[0:pos-1]) + ls[pos+2:])
        
        else:
            raise RuntimeError, "invalid formmula: (%r)" % (ls,)



def find_pair(s0):
    
    n=0
    for i, c in enumerate(s0):
        if c in '()': n+= (1 if c=='(' else -1)
        if n==0: return i
    else:
        raise RuntimeError, "Cannot find the close parenthesis!"
        

            
def read_str(str):
    
    def _iter(s, ls):
        s=s.strip()
        if(s):
            obj=RE_FORM.match(s)
            if obj and obj.group('nest'):
                idx=find_pair(s)
                return _iter(s[idx+1:], cons(_iter(s[1:idx], []), ls))
            elif obj:
                s1=s[obj.end():]
                if obj.group('num'):
                    return _iter(s1, cons((float if obj.group('after_dot') else int)(obj.group('num')), ls))
                else:
                    op_name = obj.group('op_name')
                    if op_name in '+-' and  (not ls or (isinstance(ls[-1], Operator) and not ls[-1].is_lhb())):   
                        op_name = '@' + op_name
                    return _iter(s1, cons(H_OP[op_name], ls))
            else:
                raise RuntimeError, "Cannot parse input!"
        else:
            return ls

    return _iter(str, [])



if __name__=='__main__':

    interactive= len(sys.argv)>1 and sys.argv[1]=='-i'
    if interactive:
        sys.stderr.write("Available operators and constants:\n" + \
                         ', '.join([str(op) for op in L_OP if not op.is_upm()]) + \
                         "\nq:quit\n\n")
        
    str=sys.argv[1]
    if str:
        str=str.rstrip()
        try:
            print int(eval_ls(read_str(str)))
        except Exception,  strerror:
            print strerror


