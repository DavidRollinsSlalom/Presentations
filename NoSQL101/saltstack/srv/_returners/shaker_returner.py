from __future__ import absolute_import

import logging
import json
import datetime
import salt.utils.jid
import salt.returners

try:
    import sqlite3
    HAS_SQLITE3 = True
except ImportError:
    HAS_SQLITE3 = False

log = logging.getLogger(__name__)

# Define the module's virtual name
__virtualname__ = 'shaker_returns'


def __virtual__():
    if not HAS_SQLITE3:
        return False
    return __virtualname__

def _get_conn(ret=None):
    '''
    Return a sqlite3 database connection
    '''
    database = '/srv/devops_db/salt_returners'
    timeout = _options.get('10.0')

    conn = sqlite3.connect(database, timeout=float(timeout))
    return conn


def _close_conn(conn):
    '''
    Close the sqlite3 database connection
    '''
    log.debug('Closing the sqlite3 database connection')
    conn.commit()
    conn.close()


def returner(ret):
    '''
    Insert minion return data into the sqlite3 database
    '''
    log.debug('sqlite3 returner <returner> called with data: {0}'.format(ret))
    conn = _get_conn(ret)
    cur = conn.cursor()
    sql = '''INSERT INTO salt_returns
             (fun, jid, id, fun_args, date, full_ret, success)
             VALUES (:fun, :jid, :id, :fun_args, :date, :full_ret, :success)'''
    cur.execute(sql,
                {'fun': ret['fun'],
                 'jid': ret['jid'],
                 'id': ret['id'],
                 'fun_args': str(ret['fun_args']) if ret['fun_args'] else None,
                 'date': str(datetime.datetime.now()),
                 'full_ret': json.dumps(ret['return']),
                 'success': ret['success']})
    _close_conn(conn)


def save_load(jid, load):
    '''
    Save the load to the specified jid
    '''
    log.debug('sqlite3 returner <save_load> called jid:{0} load:{1}'
              .format(jid, load))
    conn = _get_conn(ret=None)
    cur = conn.cursor()
    sql = '''INSERT INTO jids (jid, load) VALUES (:jid, :load)'''
    cur.execute(sql,
                {'jid': jid,
                 'load': json.dumps(load)})
    _close_conn(conn)


def get_load(jid):
    '''
    Return the load from a specified jid
    '''
    log.debug('sqlite3 returner <get_load> called jid: {0}'.format(jid))
    conn = _get_conn(ret=None)
    cur = conn.cursor()
    sql = '''SELECT load FROM jids WHERE jid = :jid'''
    cur.execute(sql,
                {'jid': jid})
    data = cur.fetchone()
    if data:
        return json.loads(data)
    _close_conn(conn)
    return {}


def get_jid(jid):
    '''
    Return the information returned from a specified jid
    '''
    log.debug('sqlite3 returner <get_jid> called jid: {0}'.format(jid))
    conn = _get_conn(ret=None)
    cur = conn.cursor()
    sql = '''SELECT id, full_ret FROM salt_returns WHERE jid = :jid'''
    cur.execute(sql,
                {'jid': jid})
    data = cur.fetchone()
    log.debug('query result: {0}'.format(data))
    ret = {}
    if data and len(data) > 1:
        ret = {str(data[0]): {u'return': json.loads(data[1])}}
        log.debug("ret: {0}".format(ret))
    _close_conn(conn)
    return ret


def get_fun(fun):
    '''
    Return a dict of the last function called for all minions
    '''
    log.debug('sqlite3 returner <get_fun> called fun: {0}'.format(fun))
    conn = _get_conn(ret=None)
    cur = conn.cursor()
    sql = '''SELECT s.id, s.full_ret, s.jid
            FROM salt_returns s
            JOIN ( SELECT MAX(jid) AS jid FROM salt_returns GROUP BY fun, id) max
            ON s.jid = max.jid
            WHERE s.fun = :fun
            '''
    cur.execute(sql,
                {'fun': fun})
    data = cur.fetchall()
    ret = {}
    if data:
        # Pop the jid off the list since it is not
        # needed and I am trying to get a perfect
        # pylint score :-)
        data.pop()
        for minion, ret in data:
            ret[minion] = json.loads(ret)
    _close_conn(conn)
    return ret


def get_jids():
    '''
    Return a list of all job ids
    '''
    log.debug('sqlite3 returner <get_fun> called')
    conn = _get_conn(ret=None)
    cur = conn.cursor()
    sql = '''SELECT jid FROM jids'''
    cur.execute(sql)
    data = cur.fetchall()
    ret = []
    for jid in data:
        ret.append(jid[0])
    _close_conn(conn)
    return ret


def get_minions():
    '''
    Return a list of minions
    '''
    log.debug('sqlite3 returner <get_minions> called')
    conn = _get_conn(ret=None)
    cur = conn.cursor()
    sql = '''SELECT DISTINCT id FROM salt_returns'''
    cur.execute(sql)
    data = cur.fetchall()
    ret = []
    for minion in data:
        ret.append(minion[0])
    _close_conn(conn)
    return ret


def prep_jid(nocache=False, passed_jid=None):  # pylint: disable=unused-argument
    '''
    Do any work necessary to prepare a JID, including sending a custom id
    '''
    return passed_jid if passed_jid is not None else salt.utils.jid.gen_jid()

