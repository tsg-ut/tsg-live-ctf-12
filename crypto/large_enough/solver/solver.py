N = 24326846669389380123223524802871192030435630023429652573246862693029152468667707145814941828066424888906795562194717161428668900138112343374259286497584626921291031689894398616629826779119955529182749839365292025774639144685771629736103815447067012718080979581499764843999762869578975185088362797591692001287175157320204135303944212187784282508824978931001402305963450954592712554656556056209812411873886260902393854103736295746216086891439189117642726876784518677646775273668368997779962770872693634361726059710299535475055122536315336326304095438270792607926582346584129560403787122564566782068549408321262791155399
c = 8243416724888010231389342978862010470240481284077442246389084927524685817493623886452626269185829859367291187991517192069257567129540131704619835467246846110949704427591585299738243662442714659293402922615479420981791695193315906167872482796618472901443896752334214974380756277817783341391218515084652948358481567172031967878376762227713320056735369350172719836837247898940314711807543413674096976525628145734157235843816863348108092189118880412494173757777285338396867566080590524652652700677671420648660367715152054381444848787884994973776748916265877334616082819556871607030282796314294231239559945975420260605077

c_inv = pow(c, -1, N)

def cbrt_int(x):
    l, r = 1, x
    while l + 1 < r:
        m = (l + r) // 2
        if m * m * m < x:
            l = m
        else:
            r = m
    return r

m = cbrt_int(c_inv)

print(m.to_bytes((m.bit_length() + 7) // 8, 'big'))